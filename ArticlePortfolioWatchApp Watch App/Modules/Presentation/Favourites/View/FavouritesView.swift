import SwiftUI
import SwiftData

struct FavouritesView: View {
    
    @EnvironmentObject private var watchConnectivity: WatchConnectivityManager
    @StateObject private var viewModel = FavouritesViewModel()
    @Environment(\.modelContext) private var modelContext
    @Query(
        sort: \ArticleSwiftDataModel.createdAt,
        order: .reverse
    )
    private var favouriteArticles: [ArticleSwiftDataModel]
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                List {
                    ForEach(favouriteArticles, id: \.self) { article in
                        ArticleRowView(article: article.convertToArticleDto(), screenSize: proxy.size,
                                       isFavourite: false) {}
                    }
                }
                .listStyle(.carousel)
                .navigationTitle("Favourite articles")
            }
        }
    }
}

#Preview {
    FavouritesView()
        .environmentObject(WatchConnectivityManager.shared)
}
