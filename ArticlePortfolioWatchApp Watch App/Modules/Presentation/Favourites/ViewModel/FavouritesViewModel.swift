import SwiftUI
import SwiftData

protocol FavouritesViewModelProtocol: ObservableObject {
    var favouriteArticles: [ArticleDto] { get set }
}

final class FavouritesViewModel: Favourites.ViewModel {
    @Published var favouriteArticles: [ArticleDto] = []
}
