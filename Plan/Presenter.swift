open class Presenter<Translator: Plan.Translator>: Dispatchable {
    public let store: Translator.Store
    let dispatcher: Dispatcher<Translator.Action>
    let translator: Translator

    public init(store: Translator.Store, translator: Translator) {
        self.store = store
        self.translator = translator
        self.dispatcher = Dispatcher(store: store, translator: translator)
    }

    public func asDispatcher() -> AnyDispatcher<Translator.Action> {
        AnyDispatcher(self)
    }

    public func dispatch(_ action: Translator.Action) {
        dispatcher.dispatch(action)
    }
}
