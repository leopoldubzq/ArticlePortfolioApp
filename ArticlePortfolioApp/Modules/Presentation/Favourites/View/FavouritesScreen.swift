import SwiftUI
import SwiftData

struct FavouritesScreen<ViewModel: Favourites.ViewModel>: View {
    @Query(animation: .easeInOut(duration: 0.35))
    private var favouriteArticles: [ArticleSwiftDataModel]
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(favouriteArticles.sorted(by: { viewModel.sorted($0, $1) }), id: \.id) { article in
                    ArticleRowView(article: article, 
                                   onTapTrash: {
                        viewModel.updateFavouriteState(with: modelContext,
                                                       model: article,
                                                       favouriteArticles: favouriteArticles)
                    }, onTapRow: {})
                }
            }
        }
        .navigationTitle("Favourite articles")
        .toolbar {
            if favouriteArticles.count > 1 {
                SortToolbarItem()
            }
        }
    }
    
    @ViewBuilder
    private func SortToolbarItem() -> some View {
        Group {
            Menu {
                ForEach(FavouriteArticlesSortType.allCases, id: \.self) { sortOption in
                    MenuButton(sortOption: sortOption)
                }
            } label: {
                Image(systemName: "arrow.up.arrow.down")
                    .resizable()
                    .scaleEffect(0.8)
            }
        }
        .tint(.primary)
        .fontWeight(.semibold)
    }
    
    @ViewBuilder
    private func MenuButton(sortOption: FavouriteArticlesSortType) -> some View {
        if viewModel.selectedSortOption == sortOption.rawValue {
            Button(sortOption.title, systemImage: "checkmark") {
                withAnimation {
                    viewModel.selectedSortOption = sortOption.rawValue
                }
            }
        } else {
            Button(sortOption.title) {
                withAnimation {
                    viewModel.selectedSortOption = sortOption.rawValue
                }
            }
        }
    }
}

#Preview {
    FavouritesScreen(viewModel: FavouritesViewModel())
}
