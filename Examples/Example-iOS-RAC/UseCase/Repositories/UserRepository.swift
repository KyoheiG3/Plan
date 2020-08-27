import Entity
import ReactiveSwift

public protocol UserRepositoryProtocol {
    func loginUser() -> User?
    func login(userName: String, password: String) -> SignalProducer<User, Error>
    func logout()
}
