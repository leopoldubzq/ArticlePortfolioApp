import SwiftUI
import SwiftData

@main
struct ArticlePortfolioAppApp: App {
    
    //MARK: - PRIVATE PROPERTIES
    @ObservedObject private var dependencies = DependenciesFactory()
    @ObservedObject private var watchConnectivity = WatchConnectivityManager.shared
    @StateObject private var parentNavigationStore = NavigationStore(rootNode: ContentNode(),
                                                                     parentNavigationStore: nil)
    @State private var selectedTab: TabPage = .home
    
    //MARK: - VIEW BODY
    var body: some Scene {
        WindowGroup {
            GeometryReader { proxy in
                ContentView(selectedTab: $selectedTab)
                    .environmentObject(dependencies)
                    .environmentObject(watchConnectivity)
                    .fullScreenCover(isPresented: .init(
                        get: { parentNavigationStore.childFullScreenNavigationStore != nil },
                        set: { _ in parentNavigationStore.childFullScreenNavigationStore = nil }),
                                     content: {
                        if let fullScreenNavigationStore = parentNavigationStore.childFullScreenNavigationStore {
                            NavRootView(navigationStore: fullScreenNavigationStore)
                                .environmentObject(dependencies)
                        }
                    })
                    .overlay(alignment: .top) {
                        /// ToastView(proxy: proxy)
                    }
                    .modelContainer(for: ArticleSwiftDataModel.self)
            }
        }
    }
}
