import Component

extension EntranceViewController {
    static func mock() -> EntranceViewController {
        EntranceViewController(router: EntranceRouterMock())
    }
}

final class EntranceRouterMock: EntranceRouting {
    func showHome() {}
    func showMyPage() {}
}
