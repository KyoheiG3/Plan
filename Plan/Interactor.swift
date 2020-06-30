open class Interactor<Action> {
    public typealias Action = Action
    public let dispatcher: AnyDispatcher<Action>

    public init<D: Dispatchable>(dispatcher: D) where D.Action == Action {
        if let dispatcher = dispatcher as? AnyDispatcher<Action> {
            self.dispatcher = dispatcher
        }
        else {
            self.dispatcher = AnyDispatcher(dispatcher)
        }
    }
}
