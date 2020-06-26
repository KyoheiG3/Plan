import Carbon
import Entity
import UIKit

public struct HomeHeaderComponent: IdentifiableComponent {
    public var user: User?

    public var id: String? {
        user?.id
    }

    public init(user: User?) {
        self.user = user
    }

    public func referenceSize(in bounds: CGRect) -> CGSize? {
        CGSize(width: bounds.width, height: 166)
    }

    public func shouldRender(next: HomeHeaderComponent, in content: HomeHeaderView) -> Bool {
        user?.name != next.user?.name
    }
}

public final class HomeHeaderView: UIView, NibLoadable, Renderable {
    @IBOutlet private weak var textLabel: UILabel! {
        didSet {
            textLabel.font = .systemFont(ofSize: 32)
            textLabel.textColor = .darkGray
        }
    }

    public func render(with component: HomeHeaderComponent) {
        textLabel.text = "Hello! " + (component.user?.name ?? "Guest")
    }
}
