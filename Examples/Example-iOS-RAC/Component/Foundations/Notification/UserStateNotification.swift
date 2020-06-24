import ReactiveSwift

public protocol UserStateNotification: AnyObject {
    var userStateChanged: Signal<Void, Never> { get }

    func postUserStateChanged()
}
