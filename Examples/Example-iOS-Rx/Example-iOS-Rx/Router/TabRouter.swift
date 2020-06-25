import Component
import Domain
import Presentation
import UIKit

enum RootTab: Int, CaseIterable {
    case home, myPage
}

final class TabRouter: NavigationRouting {
    private(set) weak var container: TabBarController?
    private weak var rootRouter: RootRouter?
    private lazy var homeContainer = NavigationController(router: self)
    private lazy var homeRouter = NavigationRouter(container: homeContainer, tabRouter: self)
    private lazy var myPageContainer = NavigationController(router: self)
    private lazy var myPageRouter = NavigationRouter(container: myPageContainer, tabRouter: self)

    init(container: TabBarController?, rootRouter: RootRouter?) {
        self.container = container
        self.rootRouter = rootRouter

        let controllers = RootTab.allCases.map { (tag: $0.rawValue, tab: $0, controller: controller(for: $0)) }
        controllers.forEach { tag, tab, controller in
            controller.tabBarItem = UITabBarItem(
                title: String(describing: tab), image: nil, tag: tag
            )
        }
        container?.viewControllers = controllers.map(\.controller)
    }

    func select(tab: RootTab) {
        container?.selectedTab = tab
    }

    func resetTabPages() {
        RootTab.allCases.forEach(reset(tab:))
    }

    func showHome(resetRequired: Bool) {
        if resetRequired {
            reset(tab: .home)
        }
        container?.selectedTab = .home
    }

    func showMyPage(resetRequired: Bool) {
        if resetRequired {
            reset(tab: .myPage)
        }
        container?.selectedTab = .myPage
    }
}

private extension TabRouter {
    func controller(for tab: RootTab) -> NavigationController {
        switch tab {
        case .home:
            return homeContainer

        case .myPage:
            return myPageContainer
        }
    }

    func reset(tab: RootTab) {
        switch tab {
        case .home:
            let presenter = HomePresenter(store: .init(), translator: .init())
            let interactor = HomeInteractor(dispatcher: presenter.dispatcher, dependency: .default)
            let controller = HomeViewController(presenter: presenter, useCase: interactor, router: homeRouter, notification: NotificationCenter.default)
            homeContainer.viewControllers = [controller]

        case .myPage:
            let presenter = MyPagePresenter(store: .init(), translator: .init())
            let interactor = MyPageInteractor(dispatcher: presenter.dispatcher, dependency: .default)
            let controller = MyPageViewController(presenter: presenter, useCase: interactor, router: myPageRouter, notification: NotificationCenter.default)
            myPageContainer.viewControllers = [controller]
        }
    }
}

private extension UITabBarController {
    var selectedTab: RootTab? {
        get { selectedBarItemTag.flatMap(RootTab.init) }
        set { selectedBarItemTag = newValue?.rawValue }
    }
}
