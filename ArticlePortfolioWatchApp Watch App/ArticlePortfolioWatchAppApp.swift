import SwiftUI

@main
struct ArticlePortfolioWatchApp_Watch_AppApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .modelContainer(for: ArticleSwiftDataModel.self)
        }
    }
}
