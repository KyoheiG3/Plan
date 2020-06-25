import Component
import Entity
import Plan
import RxSwift

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
