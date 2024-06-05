import SwiftUI

enum HomeScreenRoute: RouterProtocol {
    case articleDetails(model: any ArticleModelProtocol)
    case settings(detents: Set<PresentationDetent>)
}
