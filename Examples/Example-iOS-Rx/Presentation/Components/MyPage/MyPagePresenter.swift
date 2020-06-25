import Component
import Domain
import Plan
import RxRelay
import RxSwift

public final class MyPagePresenter: Presenter<MyPageTranslator>, MyPagePresenterProtocol {
    public var viewModel: Observable<MyPageViewModel> {
        store.viewModel.asObservable()
    }

    public var command: Observable<MyPageViewModel.Command> {
        store.command.asObservable()
    }
}

public final class MyPageStore: Store {
    fileprivate let viewModel = BehaviorRelay(value: MyPageViewModel())
    fileprivate let command = PublishRelay<MyPageViewModel.Command>()

    public init() {}
}

public struct MyPageTranslator: Translator {
    public init() {}

    public func translate(action: MyPageInteractor.Action, store: MyPageStore) {
        switch action {
        case .updateUser(let user):
            store.viewModel.modefy { viewModel in
                viewModel.state.user = user
            }

        case .logout:
            store.command.accept(.logoutCompleted)
        }
    }
}
