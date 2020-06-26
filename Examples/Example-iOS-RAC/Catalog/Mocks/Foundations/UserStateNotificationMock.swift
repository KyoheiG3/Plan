import Component
import ReactiveSwift

final class UserStateNotificationMock: UserStateNotification {
    let userStateChanged: Signal<Void, Never> = .empty

    func postUserStateChanged() {}
}
