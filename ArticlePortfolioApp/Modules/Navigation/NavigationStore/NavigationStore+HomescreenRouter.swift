import Foundation

extension NavigationStore: HomeScreenRouterLogic {
    public func navigate(_ route: HomeScreenRoute) {
        switch route {
        case .articleDetails(let articleDetails):
            navigationPath.append(ArticleDetailNode(articleData: articleDetails))
        case .settings(let presentationDetents):
            openSheet(with: SettingsScreenNode(), presentationDetents: presentationDetents)
        }
    }
}
