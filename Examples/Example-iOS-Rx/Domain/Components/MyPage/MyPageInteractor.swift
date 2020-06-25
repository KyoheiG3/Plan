import Component
import Entity
import Plan
import RxSwift

public final class MyPageInteractor: Interactor<MyPageInteractor.Action>, MyPageUseCase {
    public enum Action {
        case updateUser(User?)
        case logout
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

    public func logout() {
        dependency.userRepository.logout()
        dispatcher.dispatch(.logout)
    }
}
