import UIKit

public protocol EntranceRouting: AnyObject {
    func showHome()
    func showMyPage()
}

public final class EntranceViewController: UIViewController {
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = .systemFont(ofSize: 32)
            titleLabel.textColor = .darkGray
            titleLabel.text = "Entrance"
        }
    }

    @IBOutlet private weak var homeButton: UIButton! {
        didSet {
            homeButton.layer.borderWidth = 2
            homeButton.layer.borderColor = UIColor.darkGray.cgColor
            homeButton.tintColor = .darkGray
            homeButton.setTitle("Home", for: .normal)
            homeButton.titleLabel?.font = .systemFont(ofSize: 17)
            homeButton.layer.cornerRadius = homeButton.bounds.height / 2
        }
    }

    @IBOutlet private weak var myPageButton: UIButton! {
        didSet {
            myPageButton.layer.borderWidth = 2
            myPageButton.layer.borderColor = UIColor.darkGray.cgColor
            myPageButton.tintColor = .darkGray
            myPageButton.setTitle("My Page", for: .normal)
            myPageButton.titleLabel?.font = .systemFont(ofSize: 17)
            myPageButton.layer.cornerRadius = myPageButton.bounds.height / 2
        }
    }

    private let router: EntranceRouting

    public init(router: EntranceRouting) {
        self.router = router
        super.init(nibName: nil, bundle: .component)
        modalPresentationStyle = .fullScreen
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        homeButton.reactive.tap
            .take(duringLifetimeOf: self)
            .observeValues { [weak self] in
                self?.router.showHome()
        }

        myPageButton.reactive.tap
            .take(duringLifetimeOf: self)
            .observeValues { [weak self] in
                self?.router.showMyPage()
        }
    }
}
