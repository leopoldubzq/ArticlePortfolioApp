import SwiftUI
import Kingfisher
import SwiftData

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    @State private var articleOptionsSheetPresented: Bool = false
    @State private var selectedArticle: ArticleDto?
    @EnvironmentObject private var watchConnectivity: WatchConnectivityManager
    @Environment(\.modelContext) private var modelContext
    @Query private var favouriteArticles: [ArticleSwiftDataModel]
    
    var body: some View {
        GeometryReader { proxy in
            NavigationStack {
                List {
                    ForEach(viewModel.articles, id: \.self) { article in
                        ArticleRowView(article: article, screenSize: proxy.size,
                                       isFavourite: isFavourite(model: article)) {
                            selectedArticle = article
                        }
                    }
                }
                .listStyle(.carousel)
                .navigationTitle {
                    Text("Tech articles")
                        .foregroundStyle(Color.primary)
                }
                .onLoad {
                    viewModel.fetchArticles()
                }
            }
            .sheet(isPresented: .init(
                get: { selectedArticle != nil },
                set: { _ in selectedArticle = nil }),
                   content: {
                if let selectedArticle {
                    ArticleOptionsView(article: self.$selectedArticle, 
                                       isFavourite: isFavourite(model: selectedArticle))
                        .environmentObject(watchConnectivity)
                }
            })
            .overlay {
                if viewModel.isLoading {
                    Loader()
                }
            }
        }
    }
    
    private func isFavourite(model: ArticleDto) -> Bool {
        viewModel.isFavourite(model: model, favouriteArticles: favouriteArticles)
    }
}

#Preview {
    HomeView()
        .environmentObject(WatchConnectivityManager.shared)
}
