import SwiftUI
import SwiftData

struct HomeScreen<ViewModel: Home.ViewModel>: View {
    
    //MARK: - PRIVATE PROPERTIES
    @Environment(\.homeScreenRouter) private var router: HomeScreenRouterLogic
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var watchConnectivity: WatchConnectivityManager
    @StateObject private var viewModel: ViewModel
    @Namespace private var selectedQueryAnimation
    @Query private var favouriteArticles: [ArticleSwiftDataModel]
    
    //MARK: - INITIALIZERS
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    //MARK: - VIEW BODY
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(viewModel.articles, id: \.self) { article in
                        ArticleRowView(article: article,
                                       isFavourite: viewModel.isFavourite(model: article,
                                                                          favouriteArticles: favouriteArticles),
                                       onTapHeart: {
                            viewModel.updateFavouriteState(with: modelContext, model: article,
                                                           favouriteArticles: favouriteArticles)
                        }, onTapRow: {
                            router.navigate(.articleDetails(model: article))
                        })
                        .frame(minHeight: 200)
                    }
                }
                .padding(.bottom)
            }
            .navigationTitle("Tech articles")
            .searchable(text: $viewModel.searchPhrase,
                        prompt: "Search for tech article")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    SettingsButton {
                        router.navigate(.settings(detents: [.large]))
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .background(.background)
            .overlay {
                Loader()
                    .opacity(viewModel.isLoading ? 1 : 0)
                    .scaleEffect(viewModel.isLoading ? 1 : 0.9)
                    .animation(.easeInOut(duration: 0.15), value: viewModel.isLoading)
            }
        }
        .onLoad {
            viewModel.fetchArticles()
        }
    }
    
    //MARK: - VIEW BUILDERS
    @ViewBuilder
    private func SettingsButton(onTap: @escaping VoidCallback) -> some View {
        Button { onTap() } label: {
            Image(systemName: "gearshape")
        }
        .tint(.primary)
    }
    
    //MARK: - PRIVATE METHODS
    private func sendFavouriteArticlesArrayToAppleWatch() {
        let articlesToSend = favouriteArticles
            .map { $0.convertToArticleDto() }
            .encoded
        WatchConnectivityManager.shared.send(articlesToSend, type: .favouriteArticlesList)
    }
    
    private func getRoute(node: AnyHashable) -> HomeScreenRoute? {
        switch node {
        case is ArticleDetailNode:
            return .articleDetails(model: ArticleDto.init())
        default:
            return nil
        }
    }
    
    private func getFavouriteArticle(model: any ArticleModelProtocol) -> ArticleSwiftDataModel? {
        favouriteArticles.first { article in
            guard let model = model as? ArticleDto else {
                return false
            }
            return article.checkIfFavourite(modelToCompare: model)
        }
    }
    
    private func isFavourite(model: any ArticleModelProtocol) -> Bool {
        getFavouriteArticle(model: model) != nil
    }
    
}

//MARK: - PREVIEW
#Preview {
    NavigationStack {
        HomeScreen(viewModel: HomeViewModel(homeDomainManager: HomeDomainManager(everythingServer: EverythingServer(),
                                                                                 topHeadlinesServer: TopHeadlinesServer())))
            .environment(\.homeScreenRouter, NavigationStore(rootNode: HomeScreenNode(), parentNavigationStore: nil))
            .environmentObject(WatchConnectivityManager.shared)
    }
}


