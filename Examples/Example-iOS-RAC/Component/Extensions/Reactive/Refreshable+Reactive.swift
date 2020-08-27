import Boundary
import ReactiveSwift

public extension Refreshable {
    var refresh: BindingTarget<Void> {
        reactive.makeBindingTarget { base, _ in
            base.refresh()
        }
    }
}
