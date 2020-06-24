import Component
import Entity
import Plan
import ReactiveSwift

public final class HomeInteractor: Interactor<HomeInteractor.Action>, HomeUseCase {
    public enum Action {
        case updateUser(User?)
    }

    public struct Dependency {
        var userRepository: UserRepositoryProtocol

        public static var `default` = Dependency(
            userRepository: UserRepository.shared
        )
    }

    private let dependency: Dependency

    public init<D: Dispatchable>(dispatcher: D, dependency: Dependency) where D.Action == Action {
        self.dependency = dependency
        super.init(dispatcher: dispatcher)
    }

    public func refresh() {
        dispatcher.dispatch(.updateUser(dependency.userRepository.loginUser()))
    }
}
