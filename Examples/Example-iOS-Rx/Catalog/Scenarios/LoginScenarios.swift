import Playbook
import Component
import SwiftUI

struct LoginScenarios: ScenarioProvider {
    static func addScenarios(into playbook: Playbook) {
        playbook.addScenarios(of: "Login") {
            Scenario("LoginViewController", layout: .sizing(h: .fill, v: 1500)) {
                LoginViewController.mock()
            }
        }
    }
}
