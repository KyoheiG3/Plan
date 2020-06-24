import Component
import Domain
import Plan
import ReactiveSwift

public final class LoginPresenter: Presenter<LoginTranslator>, LoginPresenterProtocol {
    public var viewModel: Property<LoginViewModel> {
        Property(store.viewModel)
    }

    public var command: Signal<LoginViewModel.Command, Never> {
        store.command.output
    }
}

public final class LoginStore: Store {
    fileprivate let viewModel = MutableProperty(LoginViewModel())
    fileprivate let command = Signal<LoginViewModel.Command, Never>.pipe()

    public init() {}
}

public struct LoginTranslator: Translator {
    public init() {}

    public func translate(action: LoginInteractor.Action, store: LoginStore) {
        switch action {
        case .loading:
            store.viewModel.value.loginProgress = .loading

        case .login(.success):
            store.viewModel.value.loginProgress = .loadSucceeded
            store.command.input.send(value: .loginCompleted)

        case .login(.failure(let error)):
            print("login failed \(error)")
            store.viewModel.value.loginProgress = .loadFailed
        }
    }
}
