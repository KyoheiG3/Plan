import Component
import Entity
import Plan
import ReactiveSwift

public final class UserEditInteractor: Interactor<UserEditInteractor.Action>, UserEditUseCase {
    public enum Action {
        case loading
        case edit(Result<User, Error>)
    }

    public struct Dependency {
        var userRepository: UserRepositoryProtocol

        public static var `default` = Dependency(
            userRepository: UserRepository.shared
        )
    }

    private let dependency: Dependency
    private let editDisposable: ScopedDisposable<SerialDisposable> = ScopedSerialDisposable()

    public init<D: Dispatchable>(dispatcher: D, dependency: Dependency) where D.Action == Action {
        self.dependency = dependency
        super.init(dispatcher: dispatcher)
    }

    public func edit(userName: String, password: String) {
        dispatcher.dispatch(.loading)
        editDisposable.serial = dependency.userRepository.login(userName: userName, password: password)
            .startWithResult { [weak self] result in
                self?.dispatcher.dispatch(.edit(result))
        }
    }
}
