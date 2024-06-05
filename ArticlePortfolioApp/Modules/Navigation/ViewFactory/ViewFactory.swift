import SwiftUI

struct ViewFactory: View {
    var body: some View {
        EmptyView()
    }
}

extension ViewFactory {
    @MainActor func createView(for node: AnyHashable, 
                               with dependencies: DependenciesFactory) -> some View {
        self
            .modifier(ViewFactoryModifier(node: node, dependencies: dependencies))
    }
    @MainActor func createView2(for node: AnyHashable, 
                                with dependencies: DependenciesFactory,
                                contentHeight: Binding<CGFloat>) -> some View {
        self
            .modifier(ViewFactoryModifier(node: node,
                                          dependencies: dependencies,
                                          contentHeight: contentHeight))
    }
}

@MainActor
struct ViewFactoryModifier: ViewModifier {
    
    var node: AnyHashable
    var dependencies: DependenciesFactory
    @Binding var contentHeight: CGFloat
    
    init(node: AnyHashable, dependencies: DependenciesFactory,
         contentHeight: Binding<CGFloat> = .constant(.zero)) {
        self.node = node
        self.dependencies = dependencies
        self._contentHeight = contentHeight
    }
    
    func body(content: Content) -> some View {
        createView()
    }
    
    @ViewBuilder
    func createView() -> some View {
        switch node {
        case is HomeScreenNode:
            HomeScreenResolver().resolveView(with: dependencies)
        case let node as ArticleDetailNode:
            ArticleDetailResolver().resolveView(articleNode: node)
        case is SettingsScreenNode:
            SettingsScreenResolver().resolveView(with: dependencies)
        default:
            Text("Error: No Destination")
        }
    }
}


