import ReactiveSwift
import UseCase

public extension Refreshable {
    var refresh: BindingTarget<Void> {
        reactive.makeBindingTarget { base, _ in
            base.refresh()
        }
    }
}
