import Component

extension MyPageLabelView {
    static func mock(text: String) -> MyPageLabelView {
        let view = MyPageLabelView.loadFromNib()
        view.render(with: .init(text: text, tap: {}))
        return view
    }
}
