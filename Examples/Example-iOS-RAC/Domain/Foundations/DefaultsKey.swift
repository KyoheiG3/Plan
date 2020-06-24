import Foundation

struct DefaultsKey {
    fileprivate var key: String

    static let token = DefaultsKey(key: "token")
    static let user = DefaultsKey(key: "user")
}

extension UserDefaults {
    func set(_ value: Any?, forKey key: DefaultsKey) {
        self.set(value, forKey: key.key)
    }

    func data(forKey key: DefaultsKey) -> Data? {
        self.data(forKey: key.key)
    }
}
