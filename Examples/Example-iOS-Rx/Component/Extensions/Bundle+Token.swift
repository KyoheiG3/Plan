import Foundation

extension Bundle {
    private final class Token {}

    static var component: Bundle {
        Bundle(for: Token.self)
    }
}
