import ReactiveSwift

public typealias ScopedSerialDisposable = ScopedDisposable<SerialDisposable>

public extension ScopedDisposable where Inner: SerialDisposable {
    convenience init() {
        self.init(Inner())
    }

    var serial: Disposable? {
        get { inner.inner }
        set { inner.inner = newValue }
    }
}
