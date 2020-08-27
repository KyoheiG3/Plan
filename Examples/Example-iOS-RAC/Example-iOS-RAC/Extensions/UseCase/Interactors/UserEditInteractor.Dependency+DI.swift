import Gateway
import UseCase

extension UserEditInteractor.Dependency {
    static var `default` = Self(
        userRepository: UserRepository(dependency: .default)
    )
}
