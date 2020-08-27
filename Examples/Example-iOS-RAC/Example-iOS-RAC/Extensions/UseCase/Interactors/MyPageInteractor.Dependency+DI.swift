import Gateway
import UseCase

extension MyPageInteractor.Dependency {
    static var `default` = Self(
        userRepository: UserRepository(dependency: .default)
    )
}
