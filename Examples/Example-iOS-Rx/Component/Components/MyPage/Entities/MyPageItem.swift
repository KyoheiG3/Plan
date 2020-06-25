public enum MyPageItem {
    case userEdit
    case login
    case logout

    public var text: String {
        switch self {
        case .userEdit:
            return "User Edit"

        case .login:
            return "Login"

        case .logout:
            return "Logout"
        }
    }
}
