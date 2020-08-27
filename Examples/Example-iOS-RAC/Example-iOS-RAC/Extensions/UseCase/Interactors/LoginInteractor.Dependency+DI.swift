import Gateway
import UseCase

extension LoginInteractor.Dependency {
    static var `default` = Self(
        userRepository: UserRepository(dependency: .default)
    )
}
