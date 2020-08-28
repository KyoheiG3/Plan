import Boundary
import Component
import Plan
import ReactiveSwift

public final class MyPagePresenter: Presenter<MyPageTranslator>, MyPagePresenterProtocol {
    public var viewModel: Property<MyPageViewModel> {
        Property(store.viewModel)
    }

    public var command: Signal<MyPageViewModel.Command, Never> {
        store.command.output
    }
}

public final class MyPageStore: Store {
    fileprivate let viewModel = MutableProperty(MyPageViewModel())
    fileprivate let command = Signal<MyPageViewModel.Command, Never>.pipe()

    public init() {}
}

public struct MyPageTranslator: Translator {
    public init() {}
    
    public func translate(action: MyPageUseCaseAction, store: MyPageStore) {
        switch action {
        case .updateUser(let user):
            store.viewModel.value.state.user = user

        case .logout:
            store.command.input.send(value: .logoutCompleted)
        }
    }
}
