import Entity

public enum HomeUseCaseAction {
    case updateUser(User?)
}

public protocol HomeUseCase: Refreshable {}
