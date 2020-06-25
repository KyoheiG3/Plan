import Component
import Foundation
import RxSwift

extension NotificationCenter: UserStateNotification {
    public var userStateChanged: Observable<Void> {
        rx.notification(.userStateChanged)
            .map(value: ())
    }

    public func postUserStateChanged() {
        post(name: .userStateChanged, object: nil)
    }
}

private extension Notification.Name {
    static let userStateChanged = Notification.Name(Bundle.AppInfo.id + ".UserStateChanged")
}
