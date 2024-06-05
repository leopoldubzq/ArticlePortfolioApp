import SwiftUI

protocol HomeScreenRouterLogic: AnyObject {
    func navigate(_ route: HomeScreenRoute)
}

extension EnvironmentValues {
    var homeScreenRouter: HomeScreenRouterLogic {
        get { self[HomeScreenRouterKey.self] }
        set { self[HomeScreenRouterKey.self] = newValue }
    }
}

struct HomeScreenRouterKey: EnvironmentKey {
    static let defaultValue: HomeScreenRouterLogic = DefaultHomeScreenRouter()
}

class DefaultHomeScreenRouter: HomeScreenRouterLogic {
    public func navigate(_ route: HomeScreenRoute) {
        assertionFailure()
    }
}

