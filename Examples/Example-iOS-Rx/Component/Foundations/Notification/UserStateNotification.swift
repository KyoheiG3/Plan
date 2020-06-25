import RxSwift

public protocol UserStateNotification: AnyObject {
    var userStateChanged: Observable<Void> { get }

    func postUserStateChanged()
}
