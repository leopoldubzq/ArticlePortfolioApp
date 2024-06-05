import SwiftUI

struct HomeScreen<ViewModel: Home.ViewModel>: View {
    
    //MARK: - PRIVATE PROPERTIES
    @Environment(\.homeScreenRouter) private var router: HomeScreenRouterLogic
    @StateObject private var viewModel: ViewModel
    @Namespace private var selectedQueryAnimation
    
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
                        ArticleRowView(article: article) {
                            router.navigate(.articleDetails(model: article))
                        }
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
    
    private func getRoute(node: AnyHashable) -> HomeScreenRoute? {
        switch node {
        case is ArticleDetailNode:
            return .articleDetails(model: ArticleDto.init())
        default:
            return nil
        }
    }
    
    
}

//MARK: - PREVIEW
#Preview {
    NavigationStack {
        HomeScreen(viewModel: HomeViewModel(homeServer: HomeServer()))
            .environment(\.homeScreenRouter, NavigationStore(rootNode: HomeScreenNode(), parentNavigationStore: nil))
    }
}
