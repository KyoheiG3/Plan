import Component
import Domain
import Foundation
import Presentation

final class NavigationRouter: NavigationRouting, MyPageRouting, HomeRouting, LoginRouting, UserEditRouting {
    private weak var container: NavigationController?
    private weak var tabRouter: TabRouter?

    init(container: NavigationController?, tabRouter: TabRouter?) {
        self.container = container
        self.tabRouter = tabRouter
    }

    func pushUserEdit() {
        let presenter = UserEditPresenter(store: .init(), translator: .init())
        let interactor = UserEditInteractor(dispatcher: presenter.asDispatcher(), dependency: .default)
        let controller = UserEditViewController(presenter: presenter, useCase: interactor, router: self, notification: NotificationCenter.default)
        container?.pushViewController(controller, animated: true)
    }

    func presentLogin() {
        let navigation = NavigationController(router: self)
        let router = NavigationRouter(container: navigation, tabRouter: tabRouter)
        let presenter = LoginPresenter(store: .init(), translator: .init())
        let interactor = LoginInteractor(dispatcher: presenter.asDispatcher(), dependency: .default)
        let controller = LoginViewController(presenter: presenter, useCase: interactor, router: router, notification: NotificationCenter.default)
        navigation.viewControllers = [controller]
        container?.present(navigation, animated: true)
    }

    func showHome(resetRequired: Bool = true) {
        tabRouter?.showHome(resetRequired: resetRequired)
    }

    func dismiss() {
        container?.dismiss(animated: true)
    }

    func pop() {
        container?.popViewController(animated: true)
    }
}
