import ReactiveSwift
import UIKit

public extension Reactive where Base: LoadingViewController {
    func presented(from controller: UIViewController) -> BindingTarget<Bool> {
        makeBindingTarget { [weak controller] base, isPresented in
            guard let controller = controller, base.isPresented != isPresented else { return }

            isPresented
                ? controller.present(base, animated: false)
                : base.dismiss(animated: false)
        }
    }
}

public final class LoadingViewController: UIViewController {
    @IBOutlet private weak var indicator: UIActivityIndicatorView!

    public required init() {
        super.init(nibName: nil, bundle: .component)

        modalPresentationStyle = .overFullScreen
    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
    }


    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        indicator.startAnimating()
    }

    override public func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        indicator.stopAnimating()
    }
}
