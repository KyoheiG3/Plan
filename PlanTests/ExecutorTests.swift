import XCTest
@testable import Plan

private final class ExecutorTests: XCTestCase {
    func testImmediate() {
        let excutor = Executor<Int>.immediate
        var value = 0

        excutor.job {
            value += $0
        }

        excutor.execute(work: 1)

        XCTAssertEqual(value, 1)

        let exp1 = expectation(description: "testImmediate 1")

        excutor.job {
            XCTAssertTrue(Thread.isMainThread)
            value += $0

            if value == 2 {
                exp1.fulfill()
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            excutor.execute(work: 1)
        }

        XCTAssertEqual(value, 1)
        wait(for: [exp1], timeout: 1)
        XCTAssertEqual(value, 2)

        let exp2 = expectation(description: "testImmediate 2")

        excutor.job {
            XCTAssertFalse(Thread.isMainThread)
            value += $0

            if value == 3 {
                exp2.fulfill()
            }
        }

        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + 0.1) {
            excutor.execute(work: 1)
        }

        XCTAssertEqual(value, 2)
        wait(for: [exp2], timeout: 1)
        XCTAssertEqual(value, 3)

        excutor.cancel()
        excutor.execute(work: 1)

        XCTAssertEqual(value, 3)

        excutor.job { _ in
            fatalError()
        }
        excutor.execute(work: 1)

        XCTAssertEqual(value, 3)
    }

    func testMainThreadQueue() {
        let excutor = Executor<Int>.main
        var value = 0

        let exp = expectation(description: "testMain")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            excutor.job {
                value += $0

                if value == 1 {
                    excutor.execute(work: 1)
                }
                else {
                    exp.fulfill()
                }
            }

            excutor.execute(work: 1)
            XCTAssertEqual(value, 1)
        }

        wait(for: [exp], timeout: 1)
        XCTAssertEqual(value, 2)
    }

    func testMain() {
        let excutor = Executor<Int>.main
        var value = 0

        let exp = expectation(description: "testMain")

        excutor.job {
            XCTAssertTrue(Thread.isMainThread)
            value += $0

            if value == 2 {
                exp.fulfill()
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            excutor.execute(work: 1)
        }

        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + 0.1) {
            excutor.execute(work: 1)
        }

        XCTAssertEqual(value, 0)
        wait(for: [exp], timeout: 1)
        XCTAssertEqual(value, 2)
    }

    func testQueue() {
        let excutor = Executor<Int>.queue()
        var value = 0

        let exp = expectation(description: "testQueue")

        excutor.job {
            XCTAssertFalse(Thread.isMainThread)
            value += $0

            if value == 2 {
                exp.fulfill()
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            excutor.execute(work: 1)
        }

        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + 0.1) {
            excutor.execute(work: 1)
        }

        XCTAssertEqual(value, 0)
        wait(for: [exp], timeout: 1)
        XCTAssertEqual(value, 2)
    }
}
