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
                .navigationTitle {
                    Text("Favourite articles")
                        .foregroundStyle(Color.primary)
                }
                .overlay {
                    if favouriteArticles.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "questionmark.square")
                                .resizable()
                                .frame(width: 50, height: 50)
                            Text("Turn on your iPhone app in order to synchronize favourite articles")
                                .font(.caption2)
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundStyle(.secondary)
                    }
                }
            }
        }
    }
}

#Preview {
    FavouritesView()
        .environmentObject(WatchConnectivityManager.shared)
}
