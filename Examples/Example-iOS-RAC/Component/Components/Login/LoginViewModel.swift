public struct LoginViewModel {
    public enum Command {
        case loginCompleted
    }

    public var loginProgress: LoadProgress

    public init(
        loginProgress: LoadProgress = .default
    ) {
        self.loginProgress = loginProgress
    }
}
