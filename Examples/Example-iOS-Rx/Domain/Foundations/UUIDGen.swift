import Foundation

protocol UUIDGen {
    var uuidString: String { get }
}

extension UUID: UUIDGen {}
