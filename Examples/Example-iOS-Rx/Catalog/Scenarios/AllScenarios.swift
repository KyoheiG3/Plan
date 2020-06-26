import Playbook

struct AllScenarios: ScenarioProvider {
    static func addScenarios(into playbook: Playbook) {
        playbook
            .add(EntranceScenarios.self)
            .add(HomeScenarios.self)
            .add(LoginScenarios.self)
            .add(MyPageScenarios.self)
            .add(UserEditScenarios.self)
    }
}
