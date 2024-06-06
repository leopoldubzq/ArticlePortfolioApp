import SwiftUI
import SwiftData

protocol Persistable {
    func saveItemsInDB(_ items: [ArticleDto], withContext context: ModelContext)
    func saveItemInDB(_ item: any ArticleModelProtocol, withContext context: ModelContext)
    func remove(_ item: ArticleSwiftDataModel, withContext context: ModelContext)
}

extension Persistable {
    func saveItemsInDB(_ items: [ArticleDto], withContext context: ModelContext) {
        try? context.delete(model: ArticleSwiftDataModel.self)
        for item in items {
            context.insert(ArticleSwiftDataModel(title: item.title ?? "",
                                                 articleDescription: item.articleDescription ?? "",
                                                 articleUrl: item.articleUrl, imageUrl: item.imageUrl))
        }
        try? context.save()
    }
    
    func saveItemInDB(_ item: any ArticleModelProtocol, withContext context: ModelContext) {
        context.insert(
            ArticleSwiftDataModel(title: item.title ?? "",
                                  articleDescription: item.articleDescription ?? "",
                                  articleUrl: item.articleUrl,
                                  imageUrl: item.imageUrl)
        )
        try? context.save()
    }
    
    func remove(_ item: ArticleSwiftDataModel, withContext context: ModelContext) {
        context.delete(item)
        try? context.save()
    }
}
