import XCTest
@testable import Plan

private final class TranslatorTests: XCTestCase {
    func testTranslator() {
        final class TranslatorMainMock: Translator {
            typealias Action = Never
            final class Store: Plan.Store {}
            var executor: Executor<Never> = .main
            func translate(action: Action, store: Store) {}
        }

        XCTAssertTrue(TranslatorMock().executor.queue is ImmediateQueue)
        XCTAssertTrue(TranslatorMainMock().executor.queue is MainThreadQueue)
    }
}
