import Carbon
import Entity
import ReactiveSwift
import UIKit

public protocol HomeRouting: AnyObject {}

public protocol HomeUseCase: Refreshable {}

public protocol HomePresenterProtocol {
    var dataState: Property<HomeComposer.State> { get }
}

public final class HomeViewController: UIViewController, Renderable {
    private let presenter: HomePresenterProtocol
    private let useCase: HomeUseCase
    private let router: HomeRouting
    private let notification: UserStateNotification

    private let renderer = Renderer(
        adapter: UITableViewAdapter(),
        updater: UITableViewUpdater()
    )

    private var composer: HomeComposer {
        HomeComposer()
    }

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.allowsSelection = false
            tableView.delaysContentTouches = false
            tableView.separatorStyle = .none
        }
    }

    public init(
        presenter: HomePresenterProtocol,
        useCase: HomeUseCase,
        router: HomeRouting,
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

        useCase.refresh <~ reactive.viewWillAppear.take(first: 1)
            .merge(with: notification.userStateChanged)

        reactive.render <~ presenter.dataState
    }

    public func render(with dataState: HomeComposer.State) {
        renderer.render {
            composer.compose(state: dataState)
        }
    }
}
