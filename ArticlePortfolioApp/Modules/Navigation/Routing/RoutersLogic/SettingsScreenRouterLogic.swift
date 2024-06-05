import SwiftUI

protocol SettingsScreenRouterLogic: AnyObject {
    func navigate(_ route: SettingsScreenRoute)
}

class DefaultSettingsScreenRouter: SettingsScreenRouterLogic {
    public func navigate(_ route: SettingsScreenRoute) {
        assertionFailure()
    }
}

extension EnvironmentValues {
    var settingsScreenRouter: SettingsScreenRouterLogic {
        get { self[SettingsScreenRouterKey.self] }
        set { self[SettingsScreenRouterKey.self] = newValue }
    }
}

struct SettingsScreenRouterKey: EnvironmentKey {
    static let defaultValue: SettingsScreenRouterLogic = DefaultSettingsScreenRouter()
}
