import UIKit

public extension UIViewController {
    var isPresented: Bool {
        presentingViewController.isSome
    }

    func add(childController controller: UIViewController, to view: UIView? = nil) {
        addChild(controller)
        let parentView: UIView = view ?? self.view
        controller.view.frame = parentView.bounds
        parentView.addSubview(controller.view)
        controller.didMove(toParent: self)
    }

    func removeFromParentController() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
