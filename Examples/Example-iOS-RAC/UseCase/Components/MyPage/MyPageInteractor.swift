import Boundary
import Plan
import ReactiveSwift

public final class MyPageInteractor: Interactor<MyPageUseCaseAction>, MyPageUseCase {
    public struct Dependency {
        public var userRepository: UserRepositoryProtocol

        public init(
            userRepository: UserRepositoryProtocol
        ) {
            self.userRepository = userRepository
        }
    }

    private let dependency: Dependency

    public init<D: Dispatchable>(dispatcher: D, dependency: Dependency) where D.Action == Action {
        self.dependency = dependency
        super.init(dispatcher: dispatcher)
    }

    public func refresh() {
        dispatcher.dispatch(.updateUser(dependency.userRepository.loginUser()))
    }

    public func logout() {
        dependency.userRepository.logout()
        dispatcher.dispatch(.logout)
    }
}
