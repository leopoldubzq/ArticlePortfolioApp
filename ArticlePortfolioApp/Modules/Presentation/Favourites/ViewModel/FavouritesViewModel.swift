import SwiftUI

protocol FavouritesViewModelProtocol: ObservableObject {
    var selectedSortOption: String { get set }
    func sorted(_ article1: any ArticleModelProtocol, _ article2: any ArticleModelProtocol) -> Bool
}

final class FavouritesViewModel: Favourites.ViewModel {
    @AppStorage("selectedExpensesSortOption")
    var selectedSortOption: String = FavouriteArticlesSortType.createdAt.rawValue
    
    func sorted(_ article1: any ArticleModelProtocol, _ article2: any ArticleModelProtocol) -> Bool {
        switch selectedSortOption {
        case FavouriteArticlesSortType.createdAt.rawValue:
            return article1.createdAt > article2.createdAt
        case FavouriteArticlesSortType.alphabetical(.forward).rawValue:
            return (article1.title ?? "") < (article2.title ?? "")
        case FavouriteArticlesSortType.alphabetical(.reversed).rawValue:
            return (article1.title ?? "") > (article2.title ?? "")
        default:
            return article1.createdAt > article2.createdAt
        }
    }
}
