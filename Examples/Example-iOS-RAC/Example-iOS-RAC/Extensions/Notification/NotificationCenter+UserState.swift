import Component
import Foundation
import ReactiveSwift

extension NotificationCenter: UserStateNotification {
    public var userStateChanged: Signal<Void, Never> {
        reactive.notifications(forName: .userStateChanged)
            .map(value: ())
    }

    public func postUserStateChanged() {
        post(name: .userStateChanged, object: nil)
    }
}

private extension Notification.Name {
    static let userStateChanged = Notification.Name(Bundle.Info.id + ".UserStateChanged")
}
