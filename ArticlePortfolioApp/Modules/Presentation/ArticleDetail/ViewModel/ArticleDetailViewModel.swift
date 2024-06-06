import Foundation
import SwiftData

protocol ArticleDetailViewModelProtocol: ObservableObject {
    var articleModel: any ArticleModelProtocol { get set }
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


