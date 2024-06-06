import SwiftUI
import SwiftData

final class ArticleOptionsViewModel: FavouriteArticlesProtocol & BaseViewModel {
    @Published var favouriteArticles: [ArticleDto] = []
}
