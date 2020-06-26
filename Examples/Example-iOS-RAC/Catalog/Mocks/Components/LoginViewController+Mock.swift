import Component
import ReactiveSwift
import UseCase

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
    let viewModel: Property<LoginViewModel> = .init(value: .init())
    let command: Signal<LoginViewModel.Command, Never> = .empty
}

final class LoginUseCaseMock: LoginUseCase {
    func login(userName: String, password: String) {}
}

final class LoginRouterMock: LoginRouting {
    func dismiss() {}
}
