import RxSwift
import UIKit

public protocol RootRouting: AnyObject {
    func showTabPages()
    func showEntrance()
}

public final class RootViewController: UIViewController {
    private let router: RootRouting
    private let disposeBag = DisposeBag()

    public init(router: RootRouting) {
        self.router = router
        super.init(nibName: nil, bundle: .component)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        rx.sentMessage(#selector(viewDidAppear)).map(value: ())
            .take(1)
            .subscribe(onNext: { [weak self] _ in
                self?.router.showEntrance()
            })
            .disposed(by: disposeBag)
    }
}
