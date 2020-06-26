import Component
import Entity
import ReactiveSwift
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
    let dataState: Property<HomeComposer.State>

    init(user: User?) {
        dataState = .init(value: .init(user: user))
    }
}

final class HomeUseCaseMock: HomeUseCase {
    func refresh() {}
}

final class HomeRouterMock: HomeRouting {}
