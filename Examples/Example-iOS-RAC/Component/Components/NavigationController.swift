import UIKit

public protocol NavigationRouting: AnyObject {

}

public final class NavigationController: UINavigationController {
    public let router: NavigationRouting

    public init(router: NavigationRouting) {
        self.router = router
        super.init(nibName: nil, bundle: .component)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
