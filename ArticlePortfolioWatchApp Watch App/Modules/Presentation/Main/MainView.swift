import SwiftUI
import SwiftData

struct MainView: View {
    
    @StateObject private var watchConnectivity = WatchConnectivityManager.shared
    @Environment(\.modelContext) private var modelContext
    @Query private var favouriteArticles: [ArticleSwiftDataModel]
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        TabView {
            HomeView()
            FavouritesView()
        }
        .environmentObject(watchConnectivity)
        .tabViewStyle(.page)
        .onChange(of: watchConnectivity.notificationMessage) { _, notification in
            guard let notification else { return }
            switch notification.type {
            case .favouriteArticlesList:
                viewModel.saveItemsInDB(notification.favouriteArticlesList ?? [], withContext: modelContext)
            default:
                break
            }
        }
    }
}

#Preview {
    MainView()
}
