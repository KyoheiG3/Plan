open class Presenter<Translator: Plan.Translator> {
    public let store: Translator.Store
    public let dispatcher: Dispatcher<Translator.Action>
    let translator: Translator

    public init(store: Translator.Store, translator: Translator) {
        self.store = store
        self.translator = translator
        self.dispatcher = Dispatcher(store: store, translator: translator)
    }
}
