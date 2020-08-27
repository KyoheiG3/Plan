import Boundary
import Carbon
import Entity
import RxSwift
import UIKit

public protocol MyPageRouting: AnyObject {
    func presentLogin()
    func pushUserEdit()
    func showHome(resetRequired: Bool)
}

public protocol MyPagePresenterProtocol {
    var viewModel: Observable<MyPageViewModel> { get }
    var command: Observable<MyPageViewModel.Command> { get }
}

public final class MyPageViewController: UIViewController, Renderable {
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.allowsSelection = false
            tableView.delaysContentTouches = false
            tableView.tableFooterView = UIView()
        }
    }

    private let presenter: MyPagePresenterProtocol
    private let useCase: MyPageUseCase
    private let router: MyPageRouting
    private let notification: UserStateNotification
    private let disposeBag = DisposeBag()

    private let renderer = Renderer(
        adapter: UITableViewAdapter(),
        updater: UITableViewUpdater()
    )

    private var composer: MyPageComposer {
        MyPageComposer { [weak self] event in
            switch event {
            case .selectItem(.login):
                self?.router.presentLogin()

            case .selectItem(.userEdit):
                self?.router.pushUserEdit()

            case .selectItem(.logout):
                let alertController = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
                alertController.addAction(.init(title: "OK", style: .default, handler: { _ in
                    self?.useCase.logout()
                }))
                alertController.addAction(.init(title: "Cancel", style: .cancel))
                self?.present(alertController, animated: true)
            }
        }
    }

    public init(
        presenter: MyPagePresenterProtocol,
        useCase: MyPageUseCase,
        router: MyPageRouting,
        notification: UserStateNotification
    ) {
        self.presenter = presenter
        self.useCase = useCase
        self.router = router
        self.notification = notification
        super.init(nibName: nil, bundle: .component)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        renderer.target = tableView

        Observable.merge(
            rx.sentMessage(#selector(viewWillAppear)).map(value: ()).take(1),
            notification.userStateChanged
        )
            .bind(to: useCase.refresh)
            .disposed(by: disposeBag)

        presenter.viewModel
            .bind(to: rx.render)
            .disposed(by: disposeBag)

        presenter.command
            .subscribe(onNext: { [weak self] command in
                switch command {
                case .logoutCompleted:
                    self?.notification.postUserStateChanged()
                    self?.router.showHome(resetRequired: false)
                }
            })
            .disposed(by: disposeBag)
    }

    public func render(with viewModel: MyPageViewModel) {
        renderer.render {
            composer.compose(state: viewModel.state)
        }
    }
}
