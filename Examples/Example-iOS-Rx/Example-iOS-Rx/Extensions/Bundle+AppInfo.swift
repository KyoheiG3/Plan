import Foundation

extension Bundle {
    struct AppInfo {
        var key: String

        init(key: String) {
            self.key = key
        }

        func object<T>(for key: String) -> T? {
            Bundle.main.object(forInfoDictionaryKey: key) as? T
        }

        func toString() -> String {
            guard let string: String = object(for: key) else {
                fatalError(#""\#(key)" is not existing"#)
            }
            return string
        }
    }
}

extension Bundle.AppInfo {
    static var id: String {
        Bundle.main.bundleIdentifier ?? Bundle.AppInfo(key: "CFBundleIdentifier").toString()
    }
}
