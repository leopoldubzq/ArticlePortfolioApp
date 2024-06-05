import Foundation

enum TabPage: CaseIterable {
    case home
    case favourites
    
    var title: String {
        switch self {
        case .home:
            "Start"
        case .favourites:
            "Favourites"
        }
    }
    var imageName: String {
        switch self {
        case .home:
            "house"
        case .favourites:
            "heart.fill"
        }
    }
    
    var node: AnyHashable {
        switch self {
        case .home:
            HomeScreenNode()
        case .favourites:
            ArticleDetailNode(articleData: ArticleDto.init())
        }
    }
}
