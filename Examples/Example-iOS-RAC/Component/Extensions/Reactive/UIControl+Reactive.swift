import ReactiveCocoa
import ReactiveSwift
import UIKit

extension Reactive where Base: UIControl {
    var tap: Signal<Void, Never> {
        controlEvents(.touchUpInside).map(value: ())
    }
}
