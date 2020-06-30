import XCTest
@testable import Plan

private final class PresenterTests: XCTestCase {
    func testPresenter() {
        let translator = TranslatorMock()
        let presenter = Presenter(store: translator.store, translator: translator)

        presenter.dispatch(.test)

        XCTAssertEqual(translator.latestAction, .test)
        XCTAssertTrue(translator.store.isCalled)

        translator.latestAction = nil
        translator.store.isCalled = false

        presenter.asDispatcher().dispatch(.test)

        XCTAssertEqual(translator.latestAction, .test)
        XCTAssertTrue(translator.store.isCalled)
    }
}
