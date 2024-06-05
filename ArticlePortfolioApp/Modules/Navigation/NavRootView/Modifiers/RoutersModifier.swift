import SwiftUI

extension View {
    func implementRouters(with navigationStore: NavigationStore) -> some View {
        modifier(RoutersModifier(navigationStore: navigationStore))
    }
}

struct RoutersModifier: ViewModifier {
    
    var navigationStore: NavigationStore
    
    func body(content: Content) -> some View {
        content
            .environment(\.homeScreenRouter, navigationStore)
            .environment(\.articleDetailRouter, navigationStore)
            .environment(\.settingsScreenRouter, navigationStore)
        
    }
}
