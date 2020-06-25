public extension Optional {
    var isSome: Bool {
        guard case .some = self else { return false }
        return true
    }

    var isNone: Bool {
        self == nil
    }
}
