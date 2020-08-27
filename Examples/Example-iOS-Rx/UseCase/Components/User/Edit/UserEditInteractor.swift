import Boundary
import Entity
import Plan
import RxSwift

public enum UserEditUseCaseAction {
    case loading
    case edit(Result<User, Error>)
}

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
    private let editDisposeBag = DisposeBag()

    public init<D: Dispatchable>(dispatcher: D, dependency: Dependency) where D.Action == Action {
        self.dependency = dependency
        super.init(dispatcher: dispatcher)
    }

    public func edit(userName: String, password: String) {
        dispatcher.dispatch(.loading)
        dependency.userRepository.login(userName: userName, password: password)
            .subscribe(onNext: { [weak self] user in
                self?.dispatcher.dispatch(.edit(.success(user)))
            }, onError: { [weak self] error in
                self?.dispatcher.dispatch(.edit(.failure(error)))
            })
            .disposed(by: editDisposeBag)
    }
}
