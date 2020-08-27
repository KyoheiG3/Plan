import Entity
import Foundation
import RxSwift

public protocol UserRepositoryProtocol {
    func loginUser() -> User?
    func login(userName: String, password: String) -> Observable<User>
    func logout()
}
