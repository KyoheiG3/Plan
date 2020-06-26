import Playbook
import Component
import SwiftUI

struct HomeScenarios: ScenarioProvider {
    static func addScenarios(into playbook: Playbook) {
        playbook.addScenarios(of: "Home") {
            Scenario("HomeHeaderView some User", layout: .fillH) {
                HomeHeaderView.mock(user: .init(id: "", name: "User Name", password: "password"))
            }

            Scenario("HomeHeaderView empty User", layout: .fillH) {
                HomeHeaderView.mock(user: nil)
            }

            Scenario("HomeViewController some User", layout: .sizing(h: .fill, v: 1500)) {
                HomeViewController.mock(user: .init(id: "", name: "User Name", password: "password"))
            }

            Scenario("HomeViewController empty User", layout: .sizing(h: .fill, v: 1500)) {
                HomeViewController.mock(user: nil)
            }
        }
    }
}
