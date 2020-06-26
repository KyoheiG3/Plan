import Component
import Entity
import RxSwift
import UseCase

extension HomeViewController {
    static func mock(user: User?) -> HomeViewController {
        HomeViewController(
            presenter: HomePresenterMock(user: user),
            useCase: HomeUseCaseMock(),
            router: HomeRouterMock(),
            notification: UserStateNotificationMock()
        )
    }
}

final class HomePresenterMock: HomePresenterProtocol {
    let dataState: Observable<HomeComposer.State>

    init(user: User?) {
        dataState = .just(.init(user: user))
    }
}

final class HomeUseCaseMock: HomeUseCase {
    func refresh() {}
}

final class HomeRouterMock: HomeRouting {}
