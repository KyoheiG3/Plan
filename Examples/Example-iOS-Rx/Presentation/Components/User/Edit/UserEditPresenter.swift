import Component
import Plan
import RxRelay
import RxSwift
import UseCase

public final class UserEditPresenter: Presenter<UserEditTranslator>, UserEditPresenterProtocol {
    public var viewModel: Observable<UserEditViewModel> {
        store.viewModel.asObservable()
    }

    public var command: Observable<UserEditViewModel.Command> {
        store.command.asObservable()
    }
}

public final class UserEditStore: Store {
    fileprivate let viewModel = BehaviorRelay(value: UserEditViewModel())
    fileprivate let command = PublishRelay<UserEditViewModel.Command>()

    public init() {}
}

public struct UserEditTranslator: Translator {
    public init() {}

    public func translate(action: UserEditUseCaseAction, store: UserEditStore) {
        switch action {
        case .loading:
            store.viewModel.modefy { viewModel in
                viewModel.loginProgress = .loading
            }

        case .edit(.success):
            store.viewModel.modefy { viewModel in
                viewModel.loginProgress = .loadSucceeded
            }
            store.command.accept(.editCompleted)

        case .edit(.failure(let error)):
            print("edit failed \(error)")
            store.viewModel.modefy { viewModel in
                viewModel.loginProgress = .loadFailed
            }
        }
    }
}
