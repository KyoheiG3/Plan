import Dispatch

public final class Executor<Value> {
    public static var immediate: Executor {
        .init(ImmediateQueue())
    }

    public static var main: Executor {
        .init(MainThreadQueue())
    }

    public static func queue(_ queue: DispatchQueue = .global()) -> Executor {
        .init(queue)
    }

    let queue: Queue
    private let isCancelled = Atomic(false)
    private var _execute: ((Value) -> Void)?

    init(_ queue: Queue) {
        self.queue = queue
    }

    func job(_ job: @escaping (Value) -> Void) {
        guard !isCancelled() else { return }
        _execute = job
    }

    func execute(work value: Value) {
        queue.execute { [weak self] in
            guard let me = self, let execute = me._execute, !me.isCancelled() else { return }
            execute(value)
        }
    }

    func cancel() {
        isCancelled.modify { $0 = true }
        _execute = nil
    }
}
