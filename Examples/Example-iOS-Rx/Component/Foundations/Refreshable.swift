import RxCocoa
import RxSwift

public protocol Refreshable: AnyObject {
    func refresh()
}

public extension Refreshable {
    var refresh: Binder<Void> {
        Binder(self) { base, _ in
            base.refresh()
        }
    }
}
