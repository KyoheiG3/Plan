import Foundation

extension Bundle {
    struct Info {
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

extension Bundle.Info {
    static var id: String {
        Bundle.main.bundleIdentifier ?? Bundle.Info(key: "CFBundleIdentifier").toString()
    }
}
