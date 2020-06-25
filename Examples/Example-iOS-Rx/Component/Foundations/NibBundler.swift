import UIKit

public protocol NibBundler: AnyObject {
    static var nib: UINib { get }
    static var nibName: String { get }
    static var nibBundle: Bundle? { get }
}

public extension NibBundler {
    static var nib: UINib {
        UINib(nibName: nibName, bundle: nibBundle)
    }

    static var nibName: String {
        String(describing: self)
    }

    static var nibBundle: Bundle? {
        Bundle(for: self)
    }
}
