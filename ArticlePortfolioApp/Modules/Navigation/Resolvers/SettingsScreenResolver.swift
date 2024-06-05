import SwiftUI

struct SettingsScreenResolver: ResolverProtocol {
    func resolveView(with dependencies: DependenciesFactory) -> some View {
        let viewModel = SettingsViewModel()
        return SettingsScreen(viewModel: viewModel)
    }
}
