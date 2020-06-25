import Component
import UIKit

final class RootRouter: TabRouting, NavigationRouting, EntranceRouting {
    private(set) weak var container: RootViewController?
    private lazy var tabContainer = TabBarController(router: self)
    private lazy var tabRouter = TabRouter(container: tabContainer, rootRouter: self)

    private var currentController: UIViewController? {
        didSet {
            oldValue?.removeFromParentController()
            guard let newValue = currentController else {
                return
            }

            container?.add(childController: newValue)
        }
    }

    init(container: RootViewController?) {
        self.container = container
    }

    func showTabPages(initialTab: RootTab) {
        tabRouter.resetTabPages()
        tabRouter.select(tab: initialTab)
        currentController = tabRouter.container
    }

    func showEntrance() {
        let controller = EntranceViewController(router: self)
        container?.present(controller, animated: false)
    }

    func showHome() {
        showTabPages(initialTab: .home)
        container?.dismiss(animated: true)
    }

    func showMyPage() {
        showTabPages(initialTab: .myPage)
        container?.dismiss(animated: true)
    }
}
