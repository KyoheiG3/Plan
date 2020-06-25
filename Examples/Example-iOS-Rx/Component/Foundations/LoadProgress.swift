public enum LoadProgress: Equatable {
    case `default`
    case loading
    case loadSucceeded
    case loadFailed

    public var isDefault: Bool {
        switch self {
        case .default:
            return true

        case .loading,
             .loadSucceeded,
             .loadFailed:
            return false
        }
    }

    public var isLoading: Bool {
        switch self {
        case .loading:
            return true

        case .default,
             .loadSucceeded,
             .loadFailed:
            return false
        }
    }

    public var isLoaded: Bool {
        switch self {
        case .loadSucceeded, .loadFailed:
            return true

        case .default, .loading:
            return false
        }
    }

    public var isLoadSucceeded: Bool {
        switch self {
        case .loadSucceeded:
            return true

        case .default, .loading, .loadFailed:
            return false
        }
    }

    public var isLoadFailed: Bool {
        switch self {
        case .loadFailed:
            return true

        case .default, .loading, .loadSucceeded:
            return false
        }
    }
}
