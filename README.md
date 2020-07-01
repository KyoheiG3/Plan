# Plan

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Version](https://img.shields.io/cocoapods/v/Plan.svg?style=flat)](http://cocoadocs.org/docsets/Plan)
[![License](https://img.shields.io/cocoapods/l/Plan.svg?style=flat)](http://cocoadocs.org/docsets/Plan)
[![Platform](https://img.shields.io/cocoapods/p/Plan.svg?style=flat)](http://cocoadocs.org/docsets/Plan)

The `Plan.framework` helps to keep your iOS application design clean. Think of it as a clean architecture. Read about clean architecture [here](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html).

## overview

The purpose of this design is to clear the processing flow and dependencies.

The ideal processing flow is as follows.

<img src="https://user-images.githubusercontent.com/5707132/85978649-1c018880-ba1a-11ea-89b6-7dfc8e4d503d.png" width="600">


If it is difficult to accept processing in `Controller`, you may prepare `Adapter` instead of `Controller` and `Adapter` may interact with `Controller`. However, the `Adapter` should not do more than necessary.

## Details

`Plan` offers five main types, but in many cases a framework that allows reactive programming is helpful.

### Interactor

Input from `Controller` is processed.
Data I/O and API calls are also performed here.
When the processing is completed, execute the action of `Dispatcher`.
It is included in the `Domain Layer`.

```swift
enum LoginUseCaseAction {
    case loading
    case login(Result<User, Error>)
}

protocol LoginUseCase {
    func login(userName: String, password: String)
}

class LoginInteractor: Interactor<LoginUseCaseAction>, LoginUseCase {
    let disposeBag = DisposeBag()

    func login(userName: String, password: String) {
        dispatcher.dispatch(.loading)
        userRepository.login(userName: userName, password: password)
            .subscribe(onNext: { [weak self] user in
                self?.dispatcher.dispatch(.login(.success(user)))
            }, onError: { [weak self] error in
                self?.dispatcher.dispatch(.login(.failure(error)))
            })
            .disposed(by: disposeBag)
    }
}
```

### Dispatcher

Pass the Output by `Interactor` to `Translator`.

### Store

Store the state of `View`.
The status is changed by the `Translator`.
It is included in the `Presentation Layer`.

```swift
class LoginStore: Store {
    let viewModel = BehaviorRelay(value: LoginViewModel())
}
```

### Translator

The data received from the `Interactor` is converted into the data for configuring the `View` and the state of the `Store` is updated.
It is included in the `Presentation Layer`.

```swift
struct LoginTranslator: Translator {
    func translate(action: LoginUseCaseAction, store: LoginStore) {
        switch action {
        case .loading:
            store.viewModel.modefy { viewModel in
                viewModel.loginProgress = .loading
            }

        case .login(.success(let user)):
            store.viewModel.modefy { viewModel in
                viewModel.user = user
                viewModel.loginProgress = .loadSucceeded
            }

        case .login(.failure(let error)):
            print("login failed \(error)")
            store.viewModel.modefy { viewModel in
                viewModel.loginProgress = .loadFailed
            }
        }
    }
}
```

### Presenter

Convert the stored state to the optimal form for `View` to use.
It is included in the `Presentation Layer`.

```swift
class LoginPresenter: Presenter<LoginTranslator>, LoginPresenterProtocol {
    var viewModel: Observable<LoginViewModel> {
        store.viewModel.asObservable()
    }
}
```

When initializing the `Interactor`, pass the `Presenter` instance as the `Dispatcher`.

```swift
let presenter = LoginPresenter(store: LoginStore(), translator: LoginTranslator())
let interactor = LoginInteractor(dispatcher: presenter.asDispatcher())
```

Normally, the `Action` that can be dispatched to the `Presenter` is limited to the one defined in the `Translator`, but if there are multiple `UseCase`, by overloading the `asDispatcher()` method, It is possible to dispatch to multiple `Interactor`.

```swift
class LoginPresenter: Presenter<LoginTranslator>, LoginPresenterProtocol {
    var viewModel: Observable<LoginViewModel> {
        store.viewModel.asObservable()
    }

    func asDispatcher() -> AnyDispatcher<UserInfoUseCaseAction> {
        AnyDispatcher(self)
            .map { (action: UserInfoUseCaseAction) in
                // Convert UserInfoUseCaseAction to LoginTranslator.Action
        }
    }
}

let presenter = LoginPresenter(store: LoginStore(), translator: LoginTranslator())

// Can dispatch to one Presenter from multiple Interactors.
let loginInteractor = LoginInteractor(dispatcher: presenter.asDispatcher())
let userInfoInteractor = UserInfoInteractor(dispatcher: presenter.asDispatcher())
```

### More details

See [Examples](./Examples).

## Requirements

- Swift 5.0
- iOS 10.0 or later
- macOS 10.12 or later
- tvOS 10.0 or later
- watchOS 3.0 or later

## Installation

#### CocoaPods

Add the following to your `Podfile`:

```Ruby
pod "Plan"
```

#### Carthage

Add the following to your `Cartfile`:

```Ruby
github "KyoheiG3/Plan"
```

## Acknowledgements

I've always used [VueFlux](https://github.com/ra1028/VueFlux) inside the architecture, but I've created a `Plan` in an attempt to make it simpler and easier for module testing.

## LICENSE
Under the MIT license. See [LICENSE](./LICENSE) file for details.
