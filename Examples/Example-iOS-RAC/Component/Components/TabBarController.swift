import UIKit

public protocol TabRouting: AnyObject {

}

public final class TabBarController: UITabBarController {
    public let router: TabRouting

    public init(router: TabRouting) {
        self.router = router
        super.init(nibName: nil, bundle: .component)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

    }
}
