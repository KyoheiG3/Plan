import Playbook
import Component
import SwiftUI

struct MyPageScenarios: ScenarioProvider {
    static func addScenarios(into playbook: Playbook) {
        playbook.addScenarios(of: "MyPage") {
            Scenario("MyPageLabelView", layout: .fillH) {
                MyPageLabelView.mock(text: "Scenario Test")
            }

            Scenario("MyPageUserView some User", layout: .fillH) {
                MyPageUserView.mock(user: .init(id: "", name: "User Name", password: "password"))
            }

            Scenario("MyPageUserView empty User", layout: .fillH) {
                MyPageUserView.mock(user: nil)
            }

            Scenario("MyPageViewController some User", layout: .sizing(h: .fill, v: 1500)) {
                MyPageViewController.mock(user: .init(id: "", name: "User Name", password: "password"))
            }

            Scenario("MyPageViewController empty User", layout: .sizing(h: .fill, v: 1500)) {
                MyPageViewController.mock(user: nil)
            }
        }
    }
}
