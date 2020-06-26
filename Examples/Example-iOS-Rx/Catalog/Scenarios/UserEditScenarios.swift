import Playbook
import Component
import SwiftUI

struct UserEditScenarios: ScenarioProvider {
    static func addScenarios(into playbook: Playbook) {
        playbook.addScenarios(of: "UserEdit") {
            Scenario("UserEditViewController", layout: .sizing(h: .fill, v: 1500)) {
                UserEditViewController.mock()
            }
        }
    }
}
