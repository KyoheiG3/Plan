import UIKit

extension UITabBarController {
    var selectedBarItemTag: Int? {
        get {
            selectedViewController?.tabBarItem.tag
        }
        set {
            selectedViewController = viewControllers?.first { controller in
                controller.tabBarItem.tag == newValue
            }
        }
    }
}
