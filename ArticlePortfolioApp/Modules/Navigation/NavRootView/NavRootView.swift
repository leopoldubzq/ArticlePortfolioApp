import SwiftUI

struct NavRootView: View {
    
    //MARK: - PRIVATE PROPERTIES
    @EnvironmentObject private var dependencies: DependenciesFactory
    @StateObject private var navigationStore: NavigationStore
    @StateObject private var contentSizeCoordinator = ContentSizeCoordinator()

    //MARK: - INITIALIZERS
    init(navigationStore: NavigationStore) {
        self._navigationStore = StateObject(wrappedValue: navigationStore)
    }

    //MARK: - VIEW BODY
    var body: some View {
        NavigationStack(path: $navigationStore.navigationPath) {
            ViewFactory()
                .createView(for: navigationStore.rootNode,
                            with: dependencies)
                .navigationDestination(for: AnyHashable.self) { node in
                    ViewFactory()
                        .createView(for: node, with: dependencies)
                }
        }
        .environmentObject(contentSizeCoordinator)
        .modifier(PresentationDetentsModifier(contentSizeCoordinator.presentationDetents))
        .sheet(isPresented: .init(
            get: { navigationStore.childSheetNavigationStore != nil },
            set: { _ in navigationStore.childSheetNavigationStore = nil }),
               content: {
            if let sheetNavigationStore = navigationStore.childSheetNavigationStore {
                NavRootView(navigationStore: sheetNavigationStore)
                    .environmentObject(contentSizeCoordinator)
                    .modifier(PresentationDetentsModifier(sheetNavigationStore.presentationDetents))
            }
        })
        .fullScreenCover(isPresented: .init(
            get: { navigationStore.childFullScreenNavigationStore != nil },
            set: { _ in navigationStore.childFullScreenNavigationStore = nil }),
                content: {
            if let fullScreenNavigationStore = navigationStore.childFullScreenNavigationStore {
                NavRootView(navigationStore: fullScreenNavigationStore)
                    .environmentObject(contentSizeCoordinator)
            }
        })
        .implementRouters(with: navigationStore)
    }
}

