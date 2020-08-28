import Entity

public enum UserEditUseCaseAction {
    case loading
    case edit(Result<User, Error>)
}

public protocol UserEditUseCase {
    func edit(userName: String, password: String)
}
