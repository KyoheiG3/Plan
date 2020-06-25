import RxCocoa
import RxSwift
import UIKit

extension Reactive where Base: UIControl {
    var tap: ControlEvent<Void> {
        controlEvent(.touchUpInside)
    }
}
