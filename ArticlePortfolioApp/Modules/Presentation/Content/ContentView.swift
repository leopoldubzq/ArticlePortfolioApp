import SwiftUI

struct ContentView: View {
    
    //MARK: - PRIVATE PROPERTIES
    @EnvironmentObject private var dependencies: DependenciesFactory
    @State private var tabItemImageAnimationTrigger: Bool = false
    @Namespace private var selectedTabAnimation
    @Binding private var selectedTab: TabPage
    
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
    }
}
