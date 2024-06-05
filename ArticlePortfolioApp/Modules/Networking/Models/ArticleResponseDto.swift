import Foundation

struct ArticleResponseDto: Codable {
    var articles: [ArticleDto]
    
    enum CodingKeys: String, CodingKey {
        case articles
    }
}
