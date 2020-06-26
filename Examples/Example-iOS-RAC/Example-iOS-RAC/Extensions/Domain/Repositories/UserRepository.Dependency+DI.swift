import Domain
import Foundation
import ReactiveSwift

extension UserRepository.Dependency {
    static let `default` = Self(
        scheduler: QueueScheduler.main,
        userDefaults: UserDefaults.standard,
        uuidGen: UUID()
    )
}
