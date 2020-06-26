import Plan
import ReactiveSwift
import UseCase

public final class LoginInteractor: Interactor<LoginUseCaseAction>, LoginUseCase {
    public struct Dependency {
        public var userRepository: UserRepositoryProtocol

        public init(
            userRepository: UserRepositoryProtocol
        ) {
            self.userRepository = userRepository
        }
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
