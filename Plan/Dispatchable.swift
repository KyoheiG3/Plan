public protocol Dispatchable {
    associatedtype Action

    func dispatch(_ action: Action)
    func asDispatcher() -> AnyDispatcher<Action>
}

public class AnyDispatcher<Action>: Dispatchable {
    private let _dispatch: (Action) -> Void

    public init<D: Dispatchable>(_ dispatcher: D) where D.Action == Action {
        _dispatch = dispatcher.dispatch
    }

    public init(dispatch: @escaping (Action) -> Void) {
        _dispatch = dispatch
    }

    public func dispatch(_ action: Action) {
        _dispatch(action)
    }

    public func asDispatcher() -> AnyDispatcher<Action> {
        self
    }

    public func map<U>(block: @escaping (U) -> Action) -> AnyDispatcher<U> {
        let dispatch = _dispatch
        return AnyDispatcher<U> { action in
            dispatch(block(action))
        }
    }
}
