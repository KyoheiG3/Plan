import UIKit

public protocol RootRouting: AnyObject {
    func showTabPages()
    func showEntrance()
}

public final class RootViewController: UIViewController {
    private let router: RootRouting

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

        reactive.viewDidAppear
            .take(first: 1)
            .take(duringLifetimeOf: self)
            .observeValues { [weak self] in
                self?.router.showEntrance()
        }
    }
}
