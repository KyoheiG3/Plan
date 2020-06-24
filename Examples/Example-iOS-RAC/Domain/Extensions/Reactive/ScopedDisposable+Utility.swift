import ReactiveSwift

public extension ScopedDisposable where Inner: SerialDisposable {
    convenience init() {
        self.init(Inner())
    }

    var serial: Disposable? {
        get { inner.inner }
        set { inner.inner = newValue }
    }
}

public extension ScopedDisposable where Inner: CompositeDisposable {
    convenience init() {
        self.init(Inner())
    }
}
