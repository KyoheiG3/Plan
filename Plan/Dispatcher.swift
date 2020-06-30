final class Dispatcher<Action>: Dispatchable {
    private let executor: Executor<Action>

    deinit {
        executor.cancel()
    }

    convenience init<T: Translator>(store: T.Store, translator: T) where T.Action == Action {
        self.init(store: store, translator: translator, executor: translator.executor)
    }

    init<T: Translator>(store: T.Store, translator: T, executor: Executor<Action>) where T.Action == Action {
        executor.job {
            translator.translate(action: $0, store: store)
        }

        self.executor = executor
    }

    func dispatch(_ action: Action) {
        executor.execute(work: action)
    }

    func asDispatcher() -> AnyDispatcher<Action> {
        AnyDispatcher(self)
    }
}
