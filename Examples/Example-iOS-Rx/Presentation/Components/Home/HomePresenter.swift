import Component
import Domain
import Plan
import RxRelay
import RxSwift

public final class HomePresenter: Presenter<HomeTranslator>, HomePresenterProtocol {
    public var dataState: Observable<HomeComposer.State> {
        store.viewModel.map(\.state)
    }
}

public final class HomeStore: Store {
    fileprivate let viewModel = BehaviorRelay(value: HomeViewModel())

    public init() {}
}

public struct HomeTranslator: Translator {
    public init() {}

    public func translate(action: HomeInteractor.Action, store: HomeStore) {
        switch action {
        case .updateUser(let user):
            store.viewModel.modefy { viewModel in
                viewModel.state.user = user
            }
        }
    }
}
