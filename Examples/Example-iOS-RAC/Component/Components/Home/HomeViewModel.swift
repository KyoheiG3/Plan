public struct HomeViewModel {
    public var state: HomeComposer.State

    public init(
        state: HomeComposer.State = .init()
    ) {
        self.state = state
    }
}
