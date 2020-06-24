public protocol Translator {
    associatedtype Action
    associatedtype Store: Plan.Store

    var executor: Executor<Action> { get }

    func translate(action: Action, store: Store)
}

public extension Translator {
    var executor: Executor<Action> {
        .immediate
    }
}
