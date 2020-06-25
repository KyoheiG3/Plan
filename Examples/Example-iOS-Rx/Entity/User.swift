import Foundation

public struct User: Codable {
    public var id: String
    public var name: String
    public var password: String

    public init(
        id: String,
        name: String,
        password: String
    ) {
        self.id = id
        self.name = name
        self.password = password
    }
}
