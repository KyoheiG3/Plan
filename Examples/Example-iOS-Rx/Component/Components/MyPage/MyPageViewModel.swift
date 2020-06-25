public struct MyPageViewModel {
    public enum Command {
        case logoutCompleted
    }

    public var state: MyPageComposer.State

    public init(
        state: MyPageComposer.State = .init()
    ) {
        self.state = state
    }
}
