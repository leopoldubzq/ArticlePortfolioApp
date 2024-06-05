import SwiftUI

enum HomeScreenRoute: RouterProtocol {
    case articleDetails(model: ArticleDto)
    case settings(detents: Set<PresentationDetent>)
}
