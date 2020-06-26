import Component
import Plan
import ReactiveSwift
import UseCase

public final class UserEditPresenter: Presenter<UserEditTranslator>, UserEditPresenterProtocol {
    public var viewModel: Property<UserEditViewModel> {
        Property(store.viewModel)
    }

    public var command: Signal<UserEditViewModel.Command, Never> {
        store.command.output
    }
}

public final class UserEditStore: Store {
    fileprivate let viewModel = MutableProperty(UserEditViewModel())
    fileprivate let command = Signal<UserEditViewModel.Command, Never>.pipe()

    public init() {}
}

public struct UserEditTranslator: Translator {
    public init() {}

    public func translate(action: UserEditUseCaseAction, store: UserEditStore) {
        switch action {
        case .loading:
            store.viewModel.value.loginProgress = .loading

        case .edit(.success):
            store.viewModel.value.loginProgress = .loadSucceeded
            store.command.input.send(value: .editCompleted)

        case .edit(.failure(let error)):
            print("edit failed \(error)")
            store.viewModel.value.loginProgress = .loadFailed
        }
    }
}
