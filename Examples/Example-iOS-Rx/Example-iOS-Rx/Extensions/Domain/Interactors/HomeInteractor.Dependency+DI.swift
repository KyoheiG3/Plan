import Domain

extension HomeInteractor.Dependency {
    static var `default` = Self(
        userRepository: UserRepository(dependency: .default)
    )
}
