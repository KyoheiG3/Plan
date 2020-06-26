import XCTest
@testable import Plan

private final class InteractorTests: XCTestCase {
    func testInteractor() {
        var action: DispatcherMock.Action?
        let dispatcher = DispatcherMock { action = $0 }

        let interactor = Interactor(dispatcher: dispatcher)
        interactor.dispatcher.dispatch(.test)

        XCTAssertEqual(action, .test)
    }
}
