import Component
import Entity

extension MyPageUserView {
    static func mock(user: User?) -> MyPageUserView {
        let view = MyPageUserView.loadFromNib()
        view.render(with: .init(user: user))
        return view
    }
}
