import Plan
import ReactiveSwift
import UseCase

public final class UserEditInteractor: Interactor<UserEditUseCaseAction>, UserEditUseCase {
    public struct Dependency {
        public var userRepository: UserRepositoryProtocol

        public init(
            userRepository: UserRepositoryProtocol
        ) {
            self.userRepository = userRepository
        }
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
