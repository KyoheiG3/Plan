import Foundation
import Gateway
import RxSwift

extension UserRepository.Dependency {
    static let `default` = Self(
        scheduler: MainScheduler.instance,
        userDefaults: UserDefaults.standard,
        uuidGen: UUID()
    )
}
