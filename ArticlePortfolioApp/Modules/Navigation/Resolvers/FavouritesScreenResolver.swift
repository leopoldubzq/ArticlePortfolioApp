import SwiftUI

@MainActor
struct FavouritesScreenResolver {
    func resolveView() -> some View {
        let viewModel = FavouritesViewModel()
        let favouritesScreen = FavouritesScreen(viewModel: viewModel)
        return favouritesScreen
    }
}
