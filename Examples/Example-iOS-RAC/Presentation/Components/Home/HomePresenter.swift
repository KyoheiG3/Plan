import Boundary
import Component
import Plan
import ReactiveSwift

public final class HomePresenter: Presenter<HomeTranslator>, HomePresenterProtocol {
    public var dataState: Property<HomeComposer.State> {
        store.viewModel.map(\.state)
    }
}

public final class HomeStore: Store {
    fileprivate let viewModel = MutableProperty(HomeViewModel())

    public init() {}
}

public struct HomeTranslator: Translator {
    public init() {}

    public func translate(action: HomeUseCaseAction, store: HomeStore) {
        switch action {
        case .updateUser(let user):
            store.viewModel.value.state.user = user
        }
    }
}
