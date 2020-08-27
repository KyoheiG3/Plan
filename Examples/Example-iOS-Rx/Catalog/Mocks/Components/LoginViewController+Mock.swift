import Boundary
import Component
import RxSwift

extension LoginViewController {
    static func mock() -> LoginViewController {
        LoginViewController(
            presenter: LoginPresenterMock(),
            useCase: LoginUseCaseMock(),
            router: LoginRouterMock(),
            notification: UserStateNotificationMock()
        )
    }
}

final class LoginPresenterMock: LoginPresenterProtocol {
    let viewModel: Observable<LoginViewModel> = .just(.init())
    let command: Observable<LoginViewModel.Command> = .empty()
}

final class LoginUseCaseMock: LoginUseCase {
    func login(userName: String, password: String) {}
}

final class LoginRouterMock: LoginRouting {
    func dismiss() {}
}
