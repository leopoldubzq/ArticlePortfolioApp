import Foundation
import SwiftData

protocol ArticleDetailViewModelProtocol: ObservableObject {
    var articleModel: any ArticleModelProtocol { get set }
    func updateFavouriteState(with modelContext: ModelContext)
    func fetchFavouriteArticlesFromDB(with modelContext: ModelContext)
}

final class ArticleDetailViewModel: ArticleDetail.ViewModel {
    
    //MARK: - PUBLIC PROPERTIES
    @Published var articleModel: any ArticleModelProtocol = ArticleDto()
    
    //MARK: - PRIVATE PROPERTIES
    private var favouriteArticles: [ArticleSwiftDataModel] = []
    
    // MARK: - Lifecycle
    init(articleData: any ArticleModelProtocol) {
        self.articleModel = articleData
    }
    
    //MARK: - PUBLIC METHODS
    func updateFavouriteState(with modelContext: ModelContext) {
        if isFavourite() {
            removeFromFavourites(with: modelContext)
        } else {
            addToFavourites(with: modelContext)
        }
    }
    
    func fetchFavouriteArticlesFromDB(with modelContext: ModelContext) {
        let descriptor = FetchDescriptor(sortBy: [
            SortDescriptor(\ArticleSwiftDataModel.createdAt, order: .reverse)
        ])
        if let favouriteArticles = try? modelContext.fetch(descriptor) {
            DispatchQueue.main.async {
                self.favouriteArticles = favouriteArticles
                try? modelContext.save()
            }
        }
    }
    
    //MARK: - PRIVATE METHODS
    private func getFavouriteArticle() -> ArticleSwiftDataModel? {
        guard !favouriteArticles.isEmpty else { return nil }
        return favouriteArticles.first { [weak self] article in
            guard let model = self?.articleModel as? ArticleDto else {
                return false
            }
            return article.checkIfFavourite(modelToCompare: model)
        }
    }
    
    private func isFavourite() -> Bool {
        getFavouriteArticle() != nil
    }
    
    private func removeFromFavourites(with modelContext: ModelContext) {
        guard let favouriteArticle = getFavouriteArticle() else {
            return
        }
        guard let index = favouriteArticles.firstIndex(of: favouriteArticle) else {
            return
        }
        modelContext.delete(favouriteArticles[index])
        try? modelContext.save()
        
    }
    
    private func addToFavourites(with modelContext: ModelContext) {
        modelContext.insert(
            ArticleSwiftDataModel(title: articleModel.title ?? "",
                                  articleDescription: articleModel.articleDescription ?? "",
                                  articleUrl: articleModel.articleUrl,
                                  imageUrl: articleModel.imageUrl)
        )
        try? modelContext.save()
    }
}


