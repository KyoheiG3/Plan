import Carbon
import ReactiveSwift
import UIKit

public protocol Renderable: AnyObject {
    associatedtype Component

    func render(with component: Component)
}

extension Reactive where Base: Renderable {
    var render: BindingTarget<Base.Component> {
        makeBindingTarget { base, component in
            base.render(with: component)
        }
    }
}

public extension Component where Content: Renderable, Content.Component == Self {
    func render(in content: Content) {
        content.render(with: self)
    }
}
