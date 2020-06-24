import Carbon
import Entity
import UIKit

public struct MyPageUserComponent: IdentifiableComponent {
    public var user: User?

    public var id: String? {
        user?.id
    }

    public init(
        user: User?
    ) {
        self.user = user
    }

    public func referenceSize(in bounds: CGRect) -> CGSize? {
        CGSize(width: bounds.width, height: 252)
    }

    public func shouldRender(next: MyPageUserComponent, in content: MyPageUserView) -> Bool {
        user?.name != next.user?.name
    }
}

public final class MyPageUserView: UIView, NibLoadable, Renderable {
    @IBOutlet private weak var imageView: UIImageView! {
        didSet {
            imageView.contentMode = .center
            imageView.tintColor = .white
            imageView.image = UIImage(named: "User", in: .component, compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
            imageView.backgroundColor = .lightGray
            imageView.layer.cornerRadius = imageView.bounds.height / 2
        }
    }

    @IBOutlet private weak var userNameLabel: UILabel! {
        didSet {
            userNameLabel.textAlignment = .center
            userNameLabel.font = .boldSystemFont(ofSize: 32)
            userNameLabel.textColor = .darkGray
        }
    }

    public func render(with component: MyPageUserComponent) {
        userNameLabel.text = component.user?.name ?? "Guest"
    }
}
