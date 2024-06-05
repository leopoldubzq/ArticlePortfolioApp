import SwiftUI

struct HomeScreenResolver: ResolverProtocol {
    func resolveView(with dependencies: DependenciesFactory) -> some View {
        let viewModel = HomeViewModel(homeServer: dependencies.homerServer)
        return HomeScreen(viewModel: viewModel)
    }
}
