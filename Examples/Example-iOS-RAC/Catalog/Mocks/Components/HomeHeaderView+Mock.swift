import Component
import Entity

extension HomeHeaderView {
    static func mock(user: User?) -> HomeHeaderView {
        let view = HomeHeaderView.loadFromNib()
        view.render(with: .init(user: user))
        return view
    }
}
