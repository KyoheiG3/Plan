import Entity

public enum LoginUseCaseAction {
    case loading
    case login(Result<User, Error>)
}

public protocol LoginUseCase {
    func login(userName: String, password: String)
}
