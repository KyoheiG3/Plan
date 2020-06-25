import UIKit
import RxSwift

public protocol LoginRouting: AnyObject {
    func dismiss()
}

public protocol LoginUseCase {
    func login(userName: String, password: String)
}

public protocol LoginPresenterProtocol {
    var viewModel: Observable<LoginViewModel> { get }
    var command: Observable<LoginViewModel.Command> { get }
}

public final class LoginViewController: UIViewController {
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = .systemFont(ofSize: 32)
            titleLabel.textColor = .darkGray
            titleLabel.text = "Login"
        }
    }

    @IBOutlet private weak var userNameView: UIView! {
        didSet {
            userNameView.layer.borderColor = UIColor.darkGray.cgColor
            userNameView.layer.borderWidth = 1
            userNameView.layer.cornerRadius = 4
        }
    }

    @IBOutlet private weak var userNameLabel: UILabel! {
        didSet {
            userNameLabel.font = .systemFont(ofSize: 12)
            userNameLabel.textColor = .darkGray
            userNameLabel.text = "Uset Name"
        }
    }

    @IBOutlet private weak var userNameTextField: UITextField! {
        didSet {
            userNameTextField.font = .systemFont(ofSize: 17)
            userNameTextField.textColor = .darkGray
            userNameTextField.borderStyle = .none
            userNameTextField.delegate = self
        }
    }

    @IBOutlet private weak var passwordView: UIView! {
        didSet {
            passwordView.layer.borderColor = UIColor.darkGray.cgColor
            passwordView.layer.borderWidth = 1
            passwordView.layer.cornerRadius = 4
        }
    }

    @IBOutlet private weak var passwordLabel: UILabel! {
        didSet {
            passwordLabel.font = .systemFont(ofSize: 12)
            passwordLabel.textColor = .darkGray
            passwordLabel.text = "Password"
        }
    }

    @IBOutlet private weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.font = .systemFont(ofSize: 17)
            passwordTextField.textColor = .darkGray
            passwordTextField.borderStyle = .none
            passwordTextField.isSecureTextEntry = true
            passwordTextField.delegate = self
        }
    }

    private let loadingViewController = LoadingViewController()
    private let presenter: LoginPresenterProtocol
    private let useCase: LoginUseCase
    private let router: LoginRouting
    private let notification: UserStateNotification
    private let disposeBag = DisposeBag()

    public init(
        presenter: LoginPresenterProtocol,
        useCase: LoginUseCase,
        router: LoginRouting,
        notification: UserStateNotification
    ) {
        self.presenter = presenter
        self.useCase = useCase
        self.router = router
        self.notification = notification
        super.init(nibName: nil, bundle: .component)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        presenter.command
            .subscribe(onNext: { [weak self] command in
                switch command {
                case .loginCompleted:
                    self?.notification.postUserStateChanged()
                    self?.router.dismiss()
                }
            })
            .disposed(by: disposeBag)

        presenter.viewModel.map(\.loginProgress.isLoading)
            .bind(to: loadingViewController.rx.presented(from: self))
            .disposed(by: disposeBag)
    }
}

extension LoginViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let userName = userNameTextField.text ?? ""
        let password = passwordTextField.text ?? ""

        if !userName.isEmpty && !password.isEmpty {
            textField.resignFirstResponder()
            useCase.login(userName: userName, password: password)
        }

        return true
    }
}
