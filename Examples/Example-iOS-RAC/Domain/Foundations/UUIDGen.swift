import Foundation

public protocol UUIDGen {
    var uuidString: String { get }
}

extension UUID: UUIDGen {}
