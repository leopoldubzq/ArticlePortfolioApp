import SwiftData
import Foundation

@Model
class ArticleSwiftDataModel: Identifiable, Equatable, ArticleModelProtocol {
    @Attribute(.unique) var id: UUID = UUID()
    let createdAt: Date = Date()
    var title: String?
    var articleDescription: String?
    var articleUrl: URL?
    var imageUrl: URL?
    
    init(title: String, articleDescription: String,
         articleUrl: URL?, imageUrl: URL?) {
        self.title = title
        self.articleDescription = articleDescription
        self.articleUrl = articleUrl
        self.imageUrl = imageUrl
    }
    
    func convertToArticleDto() -> ArticleDto {
        ArticleDto(title: title, articleDescription: articleDescription,
                   articleUrl: articleUrl, imageUrl: imageUrl)
    }
    
    func checkIfFavourite(modelToCompare model: any ArticleModelProtocol) -> Bool {
        title == model.title &&
        articleDescription == model.articleDescription &&
        articleUrl == model.articleUrl &&
        imageUrl == model.imageUrl
    }
}
