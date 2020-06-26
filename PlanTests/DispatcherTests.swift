import XCTest
@testable import Plan

private final class DispatcherTests: XCTestCase {
    func testAnyDispatcher() {
        var action: DispatcherMock.Action?
        let dispatcher = DispatcherMock { action = $0 }

        let anyDispatcher = AnyDispatcher(dispatcher: dispatcher)
        anyDispatcher.dispatch(.test)

        XCTAssertEqual(action, .test)
    }

    func testDispatcher() {
        let translator = TranslatorMock()
        let dispatcher = Dispatcher(store: translator.store, translator: translator)

        XCTAssertNil(translator.latestAction)
        XCTAssertFalse(translator.store.isCalled)

        dispatcher.dispatch(.test)

        XCTAssertEqual(translator.latestAction, .test)
        XCTAssertTrue(translator.store.isCalled)
    }
}
