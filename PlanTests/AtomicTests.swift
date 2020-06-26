import XCTest
@testable import Plan

private final class AtomicTests: XCTestCase {
    func testModify() {
        let counter = Atomic(0)

        DispatchQueue.concurrentPerform(iterations: 1000) { _ in
            counter.modify { $0 += 1 }
        }

        XCTAssertEqual(counter(), 1000)
    }
}
