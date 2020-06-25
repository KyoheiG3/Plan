import Carbon
import RxCocoa
import RxSwift
import UIKit

public protocol Renderable: AnyObject {
    associatedtype Component

    func render(with component: Component)
}

extension Reactive where Base: Renderable {
    var render: Binder<Base.Component> {
        Binder(base) { base, component in
            base.render(with: component)
        }
    }
}

public extension Component where Content: Renderable, Content.Component == Self {
    func render(in content: Content) {
        content.render(with: self)
    }
}
