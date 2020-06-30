import XCTest
@testable import Plan

private final class DispatcherTests: XCTestCase {
    func testAnyDispatcher() {
        var action: MockAction?
        let dispatcher = AnyDispatcher { action = $0 }

        let anyDispatcher = AnyDispatcher(dispatcher)
        anyDispatcher.dispatch(.test)

        XCTAssertEqual(action, .test)
    }

    func testDispatcherMap() {
        var action: DispatcherMock.Action?
        let dispatcher = DispatcherMock { action = $0 }

        let anyDispatcher: AnyDispatcher<MockAction> = dispatcher.asDispatcher()
            .map { action -> DispatcherMock.Action in
                switch action {
                case MockAction.test:
                    return DispatcherMock.Action.test
                }
        }

        anyDispatcher.dispatch(MockAction.test)

        XCTAssertEqual(action, DispatcherMock.Action.test)
    }

    func testDispatcher() {
        let translator = TranslatorMock()
        let dispatcher = Dispatcher(store: translator.store, translator: translator)

        XCTAssertNil(translator.latestAction)
        XCTAssertFalse(translator.store.isCalled)

        dispatcher.dispatch(.test)

        XCTAssertEqual(translator.latestAction, .test)
        XCTAssertTrue(translator.store.isCalled)

        translator.latestAction = nil
        translator.store.isCalled = false

        dispatcher.asDispatcher().dispatch(.test)

        XCTAssertEqual(translator.latestAction, .test)
        XCTAssertTrue(translator.store.isCalled)
    }
}
