import SwiftUI

struct HomeScreenResolver: ResolverProtocol {
    func resolveView(with dependencies: DependenciesFactory) -> some View {
        let viewModel = HomeViewModel(homeDomainManager: dependencies.homeDomainManager)
        return HomeScreen(viewModel: viewModel)
    }
}
