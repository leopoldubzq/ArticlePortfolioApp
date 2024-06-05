import SwiftData
import Foundation

@Model
class ArticleSwiftDataModel: Identifiable, Equatable {
    @Attribute(.unique) var id: UUID = UUID()
    let articleId: String
    let createdAt: Date = Date()
    var title: String
    var articleDescription: String
    var articleUrl: URL?
    var imageUrl: URL?
    
    init(articleId: String, title: String, 
         articleDescription: String, articleUrl: URL,
         imageUrl: URL?) {
        self.articleId = articleId
        self.title = title
        self.articleDescription = articleDescription
        self.articleUrl = articleUrl
        self.imageUrl = imageUrl
    }
}
