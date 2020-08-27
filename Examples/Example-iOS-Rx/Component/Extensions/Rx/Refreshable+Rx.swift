import Boundary
import RxCocoa

public extension Refreshable {
    var refresh: Binder<Void> {
        Binder(self) { base, _ in
            base.refresh()
        }
    }
}
