import SwiftData
import SwiftUI

protocol FavouriteManagable: ObservableObject & Persistable {
    func updateFavouriteState(with modelContext: ModelContext,
                              model: any ArticleModelProtocol,
                              favouriteArticles: [ArticleSwiftDataModel])
    func isFavourite(model: any ArticleModelProtocol,
                     favouriteArticles: [ArticleSwiftDataModel]) -> Bool
}

extension FavouriteManagable {
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
    
    private func getFavouriteArticle(model: any ArticleModelProtocol,
                                     favouriteArticles: [ArticleSwiftDataModel]) -> ArticleSwiftDataModel? {
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
        let item = favouriteArticles[index]
        remove(item, withContext: modelContext)
    }
    
    private func addToFavourites(with modelContext: ModelContext,
                                 articleModel: any ArticleModelProtocol) {
        saveItemInDB(articleModel, withContext: modelContext)
    }
}
