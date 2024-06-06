import SwiftUI
import SwiftData

struct ContentView: View {
    
    //MARK: - PRIVATE PROPERTIES
    @EnvironmentObject private var dependencies: DependenciesFactory
    @EnvironmentObject private var watchConnectivity: WatchConnectivityManager
    @Environment(\.modelContext) private var modelContext
    @State private var tabItemImageAnimationTrigger: Bool = false
    @Namespace private var selectedTabAnimation
    @Binding private var selectedTab: TabPage
    @StateObject private var viewModel = ContentViewModel()
    @Query private var favouriteArticles: [ArticleSwiftDataModel]
    
    //MARK: - INITIALIZER
    init(selectedTab: Binding<TabPage>) {
        self._selectedTab = selectedTab
    }
    
    //MARK: - BODY
    var body: some View {
        GeometryReader { proxy in
            TabView(selection: $selectedTab) {
                TabScreen(.home)
                    .setupTab(.home)
                TabScreen(.favourites)
                    .setupTab(.favourites)
            }
        }
        .task(id: favouriteArticles, {
            sendFavouriteArticlesArrayToAppleWatch()
        })
        .onChange(of: watchConnectivity.notificationMessage) { _, notification in
            guard let notification else { return }
            switch notification.type {
            case .favouriteArticleModel:
                guard let model = notification.model else { return }
                viewModel.updateFavouriteState(with: modelContext, model: model,
                                               favouriteArticles: favouriteArticles)
            default:
                break
            }
        }
    }
    
    private func sendFavouriteArticlesArrayToAppleWatch(messageType: WatchConnectivityMessage = .favouriteArticlesList) {
        let articlesToSend = favouriteArticles
            .map { $0.convertToArticleDto() }
            .encoded
        watchConnectivity.send(articlesToSend, type: .favouriteArticlesList)
    }
}
