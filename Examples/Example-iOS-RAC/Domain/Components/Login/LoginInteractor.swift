import Component
import Entity
import Plan
import ReactiveSwift

public final class LoginInteractor: Interactor<LoginInteractor.Action>, LoginUseCase {
    public enum Action {
        case loading
        case login(Result<User, Error>)
    }

    public struct Dependency {
        var userRepository: UserRepositoryProtocol

        public static var `default` = Dependency(
            userRepository: UserRepository.shared
        )
    }

    private let dependency: Dependency
    private let loginDisposable: ScopedDisposable<SerialDisposable> = ScopedSerialDisposable()

    public init<D: Dispatchable>(dispatcher: D, dependency: Dependency) where D.Action == Action {
        self.dependency = dependency
        super.init(dispatcher: dispatcher)
    }

    public func login(userName: String, password: String) {
        dispatcher.dispatch(.loading)
        loginDisposable.serial = dependency.userRepository.login(userName: userName, password: password)
            .startWithResult { [weak self] result in
                self?.dispatcher.dispatch(.login(result))
        }
    }
}
