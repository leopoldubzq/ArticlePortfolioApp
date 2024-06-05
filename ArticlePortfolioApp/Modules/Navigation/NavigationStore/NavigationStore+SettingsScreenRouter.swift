import SwiftUI

extension NavigationStore: SettingsScreenRouterLogic {
    func navigate(_ route: SettingsScreenRoute) {
        switch route {
        case .back:
            if parentNavigationStore?.childSheetNavigationStore != nil {
                closeSheet()
            } else if parentNavigationStore?.childFullScreenNavigationStore != nil {
                closeFullScreen()
            } else {
                _ = navigationPath.popLast()
            }
        case .settingDetails:
            navigationPath.append(ArticleDetailNode(articleData: ArticleDto.mock))
        }
    }
}
