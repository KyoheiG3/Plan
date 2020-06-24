public protocol Dispatchable {
    associatedtype Action

    func dispatch(_ action: Action)
}

public class AnyDispatcher<Action>: Dispatchable {
    public let _dispatch: (Action) -> Void

    init<D: Dispatchable>(dispatcher: D) where D.Action == Action {
        _dispatch = dispatcher.dispatch
    }

    public func dispatch(_ action: Action) {
        _dispatch(action)
    }
}
