import Foundation

extension NavigationStore: ArticleDetailRouterLogic {
    public func navigate(_ route: ArticleDetailRoute) {
        switch route {
        case .back:
            _ = navigationPath.popLast()
        case .popToRoot:
            navigationPath.removeAll()
        }
    }
}
