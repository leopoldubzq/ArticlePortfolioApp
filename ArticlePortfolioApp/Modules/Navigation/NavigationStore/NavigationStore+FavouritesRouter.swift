import Foundation

extension NavigationStore: FavouritesRouterLogic {
    public func navigate(_ route: FavouritesRoute) {
        switch route {
        case .articleDetails(let articleDetails):
            navigationPath.append(FavouritesNode())
        }
    }
}
