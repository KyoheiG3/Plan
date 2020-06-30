import Plan

final class DispatcherMock: Dispatchable {
    enum Action {
        case test
    }

    let _dispatch: (Action) -> Void

    init(action: @escaping (Action) -> Void) {
        _dispatch = action
    }

    func dispatch(_ action: Action) {
        _dispatch(action)
    }

    func asDispatcher() -> AnyDispatcher<Action> {
        AnyDispatcher(self)
    }
}
