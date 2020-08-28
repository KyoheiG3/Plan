import Boundary
import Component
import Plan
import RxRelay
import RxSwift

public final class LoginPresenter: Presenter<LoginTranslator>, LoginPresenterProtocol {
    public var viewModel: Observable<LoginViewModel> {
        store.viewModel.asObservable()
    }

    public var command: Observable<LoginViewModel.Command> {
        store.command.asObservable()
    }
}

public final class LoginStore: Store {
    fileprivate let viewModel = BehaviorRelay(value: LoginViewModel())
    fileprivate let command = PublishRelay<LoginViewModel.Command>()

    public init() {}
}

public struct LoginTranslator: Translator {
    public init() {}

    public func translate(action: LoginUseCaseAction, store: LoginStore) {
        switch action {
        case .loading:
            store.viewModel.modefy { viewModel in
                viewModel.loginProgress = .loading
            }

        case .login(.success):
            store.viewModel.modefy { viewModel in
                viewModel.loginProgress = .loadSucceeded
            }
            store.command.accept(.loginCompleted)

        case .login(.failure(let error)):
            print("login failed \(error)")
            store.viewModel.modefy { viewModel in
                viewModel.loginProgress = .loadFailed
            }
        }
    }
}
