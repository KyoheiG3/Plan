public struct UserEditViewModel {
    public enum Command {
        case editCompleted
    }

    public var loginProgress: LoadProgress

    public init(
        loginProgress: LoadProgress = .default
    ) {
        self.loginProgress = loginProgress
    }
}
