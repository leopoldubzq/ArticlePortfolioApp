import SwiftUI
import SwiftData

final class ArticleOptionsViewModel: ArticleOptions.ViewModel {
    @Published var favouriteArticles: [ArticleDto] = []
}
