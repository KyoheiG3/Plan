import Component
import RxSwift

final class UserStateNotificationMock: UserStateNotification {
    let userStateChanged: Observable<Void> = .empty()

    func postUserStateChanged() {}
}
