import SwiftUI
import SwiftData

struct ArticleOptionsView: View {
    
    @Binding var article: ArticleDto?
    var isFavourite: Bool
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var watchConnectivity: WatchConnectivityManager
    @State private var errorMessage: String?
    @Query private var favouriteArticles: [ArticleSwiftDataModel]
    @StateObject private var viewModel = ArticleOptionsViewModel()
    
    var body: some View {
        Button(isFavourite ? "Remove from favourites" : "Add to favourites",
               systemImage: isFavourite ? "heart.fill" : "heart") {
            if let article {
                sendFavouriteArticleToIPhone(article) {
                    updateFavouriteState(article)
                    closeSheet()
                }
            }
        }.alert(errorMessage ?? "",
                isPresented: .init(get: { errorMessage != nil },
                                   set: { _ in errorMessage = nil })) {
            Button("Ok") { errorMessage = nil }
        }
    }
    
    private func sendFavouriteArticleToIPhone(_ article: ArticleDto, completion: @escaping () -> ()) {
        watchConnectivity.send(article.encoded, type: .favouriteArticleModel) { error in
            if let error {
                errorMessage = error.message
            } else {
                completion()
            }
        }
    }
    
    private func updateFavouriteState(_ article: ArticleDto) {
        viewModel.updateFavouriteState(with: modelContext,
                                       model: article,
                                       favouriteArticles: favouriteArticles)
    }
    
    private func closeSheet() {
        article = nil
    }
    
    private func getFavouriteArticle(model: any ArticleModelProtocol,
                                     favouriteArticles: [ArticleSwiftDataModel]) -> ArticleSwiftDataModel? {
        return favouriteArticles.first { article in
            article.checkIfFavourite(modelToCompare: model)
        }
    }
}

#Preview {
    ArticleOptionsView(article: .constant(ArticleDto()), isFavourite: false)
        .environmentObject(WatchConnectivityManager.shared)
}
