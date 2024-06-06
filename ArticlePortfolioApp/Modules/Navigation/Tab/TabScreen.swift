import SwiftUI

struct TabScreen: View {
    
    var tabPage: TabPage
    
    //MARK: - INITIALIZERS
    init(_ tabPage: TabPage) {
        self.tabPage = tabPage
    }
    
    //MARK: - VIEW BODY
    var body: some View {
        NavRootView(
            navigationStore: NavigationStore(
                rootNode: tabPage.node,
                parentNavigationStore: nil
            ))
    }
}

//MARK: - EXTENSIONS
extension View {
    @ViewBuilder
    func setupTab(_ tab: TabPage) -> some View {
        self
            .tag(tab)
            .toolbarBackground(Color.init(uiColor: .systemBackground), for: .tabBar)
            .tabItem {
                Image(systemName: tab.imageName)
                Text(tab.title)
            }
    }
}
