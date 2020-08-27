import Boundary
import Component
import ReactiveSwift

extension UserEditViewController {
    static func mock() -> UserEditViewController {
        UserEditViewController(
            presenter: UserEditPresenterMock(),
            useCase: UserEditUseCaseMock(),
            router: UserEditRouterMock(),
            notification: UserStateNotificationMock()
        )
    }
}

final class UserEditPresenterMock: UserEditPresenterProtocol {
    let viewModel: Property<UserEditViewModel> = .init(value: .init())
    let command: Signal<UserEditViewModel.Command, Never> = .empty
}

final class UserEditUseCaseMock: UserEditUseCase {
    func edit(userName: String, password: String) {}
}

final class UserEditRouterMock: UserEditRouting {
    func pop() {}
}
