import Gateway
import UseCase

extension HomeInteractor.Dependency {
    static var `default` = Self(
        userRepository: UserRepository(dependency: .default)
    )
}
