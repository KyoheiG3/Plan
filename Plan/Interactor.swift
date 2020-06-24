open class Interactor<Action> {
    public typealias Action = Action
    public let dispatcher: AnyDispatcher<Action>

    public init<D: Dispatchable>(dispatcher: D) where D.Action == Action {
        self.dispatcher = AnyDispatcher(dispatcher: dispatcher)
    }
}
