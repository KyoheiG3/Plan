import ReactiveSwift

public protocol Refreshable: AnyObject, ReactiveExtensionsProvider {
    func refresh()
}
