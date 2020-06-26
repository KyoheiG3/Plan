import Component
import RxSwift
import UseCase

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
    let viewModel: Observable<UserEditViewModel> = .just(.init())
    let command: Observable<UserEditViewModel.Command> = .empty()
}

final class UserEditUseCaseMock: UserEditUseCase {
    func edit(userName: String, password: String) {}
}

final class UserEditRouterMock: UserEditRouting {
    func pop() {}
}
