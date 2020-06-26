import Playbook
import Component
import SwiftUI

struct EntranceScenarios: ScenarioProvider {
    static func addScenarios(into playbook: Playbook) {
        playbook.addScenarios(of: "Entrance") {
            Scenario("EntranceViewController", layout: .sizing(h: .fill, v: 1500)) {
                EntranceViewController.mock()
            }
        }
    }
}
