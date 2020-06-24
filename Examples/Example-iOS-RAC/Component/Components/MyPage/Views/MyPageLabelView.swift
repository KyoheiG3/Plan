import Carbon
import UIKit

public struct MyPageLabelComponent: IdentifiableComponent {
    public var text: String
    public var tap: () -> Void

    public var id: String {
        text
    }

    public init(
        text: String,
        tap: @escaping () -> Void
    ) {
        self.text = text
        self.tap = tap
    }

    public func referenceSize(in bounds: CGRect) -> CGSize? {
        CGSize(width: bounds.width, height: 60)
    }

    public func shouldRender(next: MyPageLabelComponent, in content: MyPageLabelView) -> Bool {
        text != next.text
    }
}

public final class MyPageLabelView: UIControl, NibLoadable, Renderable {
    @IBOutlet private weak var label: UILabel! {
        didSet {
            label.textColor = .darkGray
            label.font = .systemFont(ofSize: 24)
        }
    }

    public var tap: (() -> Void)?

    public override func awakeFromNib() {
        super.awakeFromNib()

        reactive.tap
            .take(duringLifetimeOf: self)
            .observeValues { [weak self] state in
                self?.tap?()
        }
    }

    public func render(with component: MyPageLabelComponent) {
        label.text = component.text
        tap = component.tap
    }
}
