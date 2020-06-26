import Entity

public enum MyPageUseCaseAction {
    case updateUser(User?)
    case logout
}

public protocol MyPageUseCase: Refreshable {
    func logout()
}
