import Carbon
import Entity
import UIKit

struct HomeHeaderComponent: IdentifiableComponent {
    var user: User?

    var id: String? {
        user?.id
    }

    func referenceSize(in bounds: CGRect) -> CGSize? {
        CGSize(width: bounds.width, height: 166)
    }

    func shouldRender(next: HomeHeaderComponent, in content: HomeHeaderView) -> Bool {
        user?.name != next.user?.name
    }
}

final class HomeHeaderView: UIView, NibLoadable, Renderable {
    @IBOutlet private weak var textLabel: UILabel! {
        didSet {
            textLabel.font = .systemFont(ofSize: 32)
            textLabel.textColor = .darkGray
        }
    }

    func render(with component: HomeHeaderComponent) {
        textLabel.text = "Hello! " + (component.user?.name ?? "Guest")
    }
}
