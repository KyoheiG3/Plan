import Entity
import Foundation
import RxSwift

public protocol UserRepositoryProtocol {
    func loginUser() -> User?
    func login(userName: String, password: String) -> Observable<User>
    func logout()
}

public final class UserRepository: UserRepositoryProtocol {
    public struct Dependency {
        public var scheduler: SchedulerType
        public var userDefaults: UserDefaults
        public var uuidGen: UUIDGen

        public init(
            scheduler: SchedulerType,
            userDefaults: UserDefaults,
            uuidGen: UUIDGen
        ) {
            self.scheduler = scheduler
            self.userDefaults = userDefaults
            self.uuidGen = uuidGen
        }
    }

    private let dependency: Dependency

    public init(dependency: Dependency) {
        self.dependency = dependency
    }

    public func loginUser() -> User? {
        try? dependency.userDefaults.data(forKey: .user).map {
            try JSONDecoder().decode(User.self, from: $0)
        }
    }

    public func login(userName: String, password: String) -> Observable<User> {
        let dependency = self.dependency
        return Observable.create { observer in
            let user = User(
                id: dependency.uuidGen.uuidString,
                name: userName,
                password: password
            )

            dependency.userDefaults.set(user.id, forKey: .token)

            let data = try? JSONEncoder().encode(user)
            dependency.userDefaults.set(data, forKey: .user)
            observer.onNext(user)
            observer.onCompleted()
            return Disposables.create()
        }
        .delay(.seconds(1), scheduler: dependency.scheduler)
    }

    public func logout() {
        dependency.userDefaults.set(nil, forKey: .token)
        dependency.userDefaults.set(nil, forKey: .user)
    }
}
