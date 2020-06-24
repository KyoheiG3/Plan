import Entity
import Foundation
import ReactiveSwift

protocol UserRepositoryProtocol {
    func loginUser() -> User?
    func login(userName: String, password: String) -> SignalProducer<User, Error>
    func logout()
}

final class UserRepository: UserRepositoryProtocol {
    static let shared = UserRepository(dependency: .default)

    struct Dependency {
        var scheduler: DateScheduler
        var userDefaults: UserDefaults
        var uuidGen: UUIDGen

        static let `default` = Dependency(
            scheduler: QueueScheduler.main,
            userDefaults: UserDefaults.standard,
            uuidGen: UUID()
        )
    }

    private let dependency: Dependency

    init(dependency: Dependency) {
        self.dependency = dependency
    }

    func loginUser() -> User? {
        try? dependency.userDefaults.data(forKey: .user).map {
            try JSONDecoder().decode(User.self, from: $0)
        }
    }

    func login(userName: String, password: String) -> SignalProducer<User, Error> {
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

    func logout() {
        dependency.userDefaults.set(nil, forKey: .token)
        dependency.userDefaults.set(nil, forKey: .user)
    }
}
