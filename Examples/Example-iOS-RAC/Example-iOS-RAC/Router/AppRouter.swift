import Component
import UIKit

final class AppRouter: RootRouting {
    private(set) weak var container: UIWindow?
    private var rootRouter: RootRouter?

    init(container: UIWindow?) {
        self.container = container
    }

    func start() {
        let controller = RootViewController(router: self)
        rootRouter = RootRouter(container: controller)
        container?.rootViewController = controller
        container?.makeKeyAndVisible()
    }

    func showTabPages() {
        rootRouter?.showTabPages(initialTab: .home)
    }

    func showEntrance() {
        rootRouter?.showEntrance()
    }
}
