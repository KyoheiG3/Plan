import Foundation

final class MainThreadQueue: Queue {
    let counter = Atomic(0)

    func execute(_ work: @escaping () -> Void) {
        let count = counter.modify { $0 += 1 }

        if Thread.isMainThread && count == 1 {
            work()
            counter.modify { $0 -= 1 }
        } else {
            DispatchQueue.main.async {
                work()
                self.counter.modify { $0 -= 1 }
            }
        }
    }
}
