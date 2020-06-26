import Component
import Entity
import ReactiveSwift
import UseCase

extension MyPageViewController {
    static func mock(user: User?) -> MyPageViewController {
        MyPageViewController(
            presenter: MyPagePresenterMock(user: user),
            useCase: MyPageUseCaseMock(),
            router: MyPageRouterMock(),
            notification: UserStateNotificationMock()
        )
    }
}

final class MyPagePresenterMock: MyPagePresenterProtocol {
    let viewModel: Property<MyPageViewModel>
    let command: Signal<MyPageViewModel.Command, Never> = .empty

    init(user: User?) {
        viewModel = .init(value: .init(state: .init(user: user)))
    }
}

final class MyPageUseCaseMock: MyPageUseCase {
    func refresh() {}
    func logout() {}
}

final class MyPageRouterMock: MyPageRouting {
    func presentLogin() {}
    func pushUserEdit() {}
    func showHome(resetRequired: Bool) {}
}
