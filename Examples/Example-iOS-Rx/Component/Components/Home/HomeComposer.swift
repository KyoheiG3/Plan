import Carbon
import Entity

public struct HomeComposer {
    enum SectionID {
        case contents
    }

    public struct State {
        public var user: User?

        public init(
            user: User? = nil
        ) {
            self.user = user
        }
    }

    public init() {}

    public func compose(state: State) -> Group<Section> {
        Group {
            Section(
                id: SectionID.contents,
                cells: {
                    HomeHeaderComponent(user: state.user)
            })
        }
    }
}
