import Boundary
import Plan
import RxSwift

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
    private let loginDisposeBag = DisposeBag()

    public init<D: Dispatchable>(dispatcher: D, dependency: Dependency) where D.Action == Action {
        self.dependency = dependency
        super.init(dispatcher: dispatcher)
    }

    public func login(userName: String, password: String) {
        dispatcher.dispatch(.loading)
        dependency.userRepository.login(userName: userName, password: password)
            .subscribe(onNext: { [weak self] user in
                self?.dispatcher.dispatch(.login(.success(user)))
            }, onError: { [weak self] error in
                self?.dispatcher.dispatch(.login(.failure(error)))
            })
            .disposed(by: loginDisposeBag)
    }
}
