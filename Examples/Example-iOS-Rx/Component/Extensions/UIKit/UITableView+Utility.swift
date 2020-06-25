import UIKit

extension UITableView {
    override open func touchesShouldCancel(in view: UIView) -> Bool {
        !delaysContentTouches
    }
}
