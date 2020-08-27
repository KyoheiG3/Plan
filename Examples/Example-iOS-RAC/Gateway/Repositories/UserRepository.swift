import Entity
import Foundation
import ReactiveSwift
import UseCase

public final class UserRepository: UserRepositoryProtocol {
    public struct Dependency {
        public var scheduler: DateScheduler
        public var userDefaults: UserDefaults
        public var uuidGen: UUIDGen

        public init(
            scheduler: DateScheduler,
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

    public func login(userName: String, password: String) -> SignalProducer<User, Error> {
        let dependency = self.dependency
        return SignalProducer { observer, lifetime in
            let user = User(
                id: dependency.uuidGen.uuidString,
                name: userName,
                password: password
            )

            dependency.userDefaults.set(user.id, forKey: .token)

            let data = try? JSONEncoder().encode(user)
            dependency.userDefaults.set(data, forKey: .user)
            observer.send(value: user)
            observer.sendCompleted()
        }
        .delay(1, on: dependency.scheduler)
    }

    public func logout() {
        dependency.userDefaults.set(nil, forKey: .token)
        dependency.userDefaults.set(nil, forKey: .user)
    }
}
