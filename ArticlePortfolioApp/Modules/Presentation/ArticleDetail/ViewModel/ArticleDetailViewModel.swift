import Foundation
import SwiftData

protocol ArticleDetailViewModelProtocol: ObservableObject {
    var articleModel: any ArticleModelProtocol { get set }
}

protocol FavouriteArticlesProtocol: ObservableObject {
    func updateFavouriteState(with modelContext: ModelContext,
                              model: any ArticleModelProtocol,
                              favouriteArticles: [ArticleSwiftDataModel])
    func isFavourite(model: any ArticleModelProtocol,
                     favouriteArticles: [ArticleSwiftDataModel]) -> Bool
}

extension FavouriteArticlesProtocol {
    func updateFavouriteState(with modelContext: ModelContext,
                              model: any ArticleModelProtocol,
                              favouriteArticles: [ArticleSwiftDataModel]) {
        if isFavourite(model: model, favouriteArticles: favouriteArticles) {
            removeFromFavourites(with: modelContext, model: model, favouriteArticles: favouriteArticles)
        } else {
            addToFavourites(with: modelContext, articleModel: model)
        }
    }
    
    func isFavourite(model: any ArticleModelProtocol, favouriteArticles: [ArticleSwiftDataModel]) -> Bool {
        getFavouriteArticle(model: model, favouriteArticles: favouriteArticles) != nil
    }
    
    private func getFavouriteArticle(model: any ArticleModelProtocol, favouriteArticles: [ArticleSwiftDataModel]) -> ArticleSwiftDataModel? {
        return favouriteArticles.first { article in
            article.checkIfFavourite(modelToCompare: model)
        }
    }
    
    private func removeFromFavourites(with modelContext: ModelContext, 
                                      model: any ArticleModelProtocol,
                                      favouriteArticles: [ArticleSwiftDataModel]) {
        guard let favouriteArticle = getFavouriteArticle(model: model, favouriteArticles: favouriteArticles),
              let index = favouriteArticles.firstIndex(of: favouriteArticle) else {
            return
        }
        modelContext.delete(favouriteArticles[index])
        try? modelContext.save()
    }
    
    private func addToFavourites(with modelContext: ModelContext, 
                                 articleModel: any ArticleModelProtocol) {
        modelContext.insert(
            ArticleSwiftDataModel(title: articleModel.title ?? "",
                                  articleDescription: articleModel.articleDescription ?? "",
                                  articleUrl: articleModel.articleUrl,
                                  imageUrl: articleModel.imageUrl)
        )
        try? modelContext.save()
    }
}

final class ArticleDetailViewModel: ArticleDetail.ViewModel {
    
    //MARK: - PUBLIC PROPERTIES
    @Published var articleModel: any ArticleModelProtocol = ArticleDto()
    var favouriteArticles: [ArticleSwiftDataModel] = []
    
    // MARK: - Lifecycle
    init(articleData: any ArticleModelProtocol) {
        self.articleModel = articleData
    }
}


