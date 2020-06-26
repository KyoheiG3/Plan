import XCTest
@testable import Plan

private final class PresenterTests: XCTestCase {
    func testPresenter() {
        let translator = TranslatorMock()
        let presenter = Presenter(store: translator.store, translator: translator)

        presenter.dispatcher.dispatch(.test)

        XCTAssertEqual(translator.latestAction, .test)
        XCTAssertTrue(translator.store.isCalled)
    }
}
