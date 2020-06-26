import Plan

final class TranslatorMock: Translator {
    enum Action {
        case test
    }

    final class Store: Plan.Store {
        var isCalled = false
    }

    let store = Store()
    var latestAction: Action?

    func translate(action: Action, store: Store) {
        latestAction = action
        store.isCalled = true
    }
}
