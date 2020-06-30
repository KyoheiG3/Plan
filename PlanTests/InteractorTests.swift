import XCTest
@testable import Plan

private final class InteractorTests: XCTestCase {
    func testInteractorWithDispatchable() {
        var action: DispatcherMock.Action?
        let dispatcher = DispatcherMock { action = $0 }

        let interactor = Interactor(dispatcher: dispatcher)
        interactor.dispatcher.dispatch(.test)

        XCTAssertEqual(action, .test)
    }

    func testInteractorAnyDispatcher() {
        var action: MockAction?
        let dispatcher = AnyDispatcher { action = $0 }

        let interactor = Interactor(dispatcher: dispatcher.asDispatcher())
        interactor.dispatcher.dispatch(.test)

        XCTAssertEqual(action, .test)
    }
}
