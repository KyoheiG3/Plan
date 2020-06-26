import Component
import Entity
import RxSwift
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
    let viewModel: Observable<MyPageViewModel>
    let command: Observable<MyPageViewModel.Command> = .empty()

    init(user: User?) {
        viewModel = .just(.init(state: .init(user: user)))
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
