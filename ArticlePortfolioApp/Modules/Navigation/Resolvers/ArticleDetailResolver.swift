import SwiftUI

@MainActor
struct ArticleDetailResolver {
    func resolveView(articleNode: ArticleDetailNode) -> some View {
        let viewModel = ArticleDetailViewModel(articleData: articleNode.articleData)
        let articleView = ArticleDetailScreen(viewModel: viewModel)
        return articleView
    }
}
