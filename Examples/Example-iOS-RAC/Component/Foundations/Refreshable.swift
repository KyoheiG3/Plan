import ReactiveSwift

public protocol Refreshable: AnyObject, ReactiveExtensionsProvider {
    func refresh()
}

public extension Refreshable {
    var refresh: BindingTarget<Void> {
        reactive.makeBindingTarget { base, _ in
            base.refresh()
        }
    }
}
