import Foundation
import SwiftUI

struct ArticleDetailNode: Hashable {
    
    private let uuid: UUID = UUID()
    
    let articleData: ArticleDto
    
    init(articleData: ArticleDto) {
        self.articleData = articleData
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(articleData)
    }
    
    static func == (lhs: ArticleDetailNode, rhs: ArticleDetailNode) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
