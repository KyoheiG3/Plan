import Foundation

final class Atomic<Value> {
    private var _value: Value
    private var lock = os_unfair_lock_s()

    init(_ value: Value) {
        _value = value
    }

    func callAsFunction() -> Value {
        defer { os_unfair_lock_unlock(&lock) }
        os_unfair_lock_lock(&lock)
        return _value
    }

    @discardableResult
    func modify(block: (inout Value) -> Void) -> Value {
        defer { os_unfair_lock_unlock(&lock) }
        os_unfair_lock_lock(&lock)
        block(&_value)
        return _value
    }
}
