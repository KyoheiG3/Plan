import Carbon
import Entity

public struct MyPageComposer {
    enum SectionID {
        case contents
    }

    public enum Event {
        case selectItem(MyPageItem)
    }

    public struct State {
        public var user: User?

        public init(
            user: User? = nil
        ) {
            self.user = user
        }
    }

    public var event: (Event) -> Void

    public init(
        event: @escaping (Event) -> Void
    ) {
        self.event = event
    }

    public func compose(state: State) -> Group<Section> {
        Group {
            Section(
                id: SectionID.contents,
                cells: {
                    MyPageUserComponent(user: state.user)

                    if state.user.isNone {
                        MyPageLabelComponent(text: MyPageItem.login.text) {
                            self.event(.selectItem(.login))
                        }
                    }
                    else {
                        MyPageLabelComponent(text: MyPageItem.userEdit.text) {
                            self.event(.selectItem(.userEdit))
                        }

                        MyPageLabelComponent(text: MyPageItem.logout.text) {
                            self.event(.selectItem(.logout))
                        }
                    }
            })
        }
    }
}
