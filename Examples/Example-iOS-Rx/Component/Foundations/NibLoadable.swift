import Carbon
import UIKit

public protocol NibLoadable: NibBundler {}

public extension NibLoadable where Self: UIView {
    static func loadFromNib() -> Self {
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError("The nib \(nib) expected its root view to be of type \(self)")
        }
        return view
    }
}

public extension Component where Content: UIView & NibLoadable {
    func renderContent() -> Content {
        .loadFromNib()
    }
}
