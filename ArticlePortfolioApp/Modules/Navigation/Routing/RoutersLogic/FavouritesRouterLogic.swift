import SwiftUI

protocol FavouritesRouterLogic: AnyObject {
    func navigate(_ route: FavouritesRoute)
}

class DefaultFavouritesRouter: FavouritesRouterLogic {
    public func navigate(_ route: FavouritesRoute) {
        assertionFailure()
    }
}

extension EnvironmentValues {
    var favouritesRouter: FavouritesRouterLogic {
        get { self[FavouritesRouterKey.self] }
        set { self[FavouritesRouterKey.self] = newValue }
    }
}

struct FavouritesRouterKey: EnvironmentKey {
    static let defaultValue: FavouritesRouterLogic = DefaultFavouritesRouter()
}

