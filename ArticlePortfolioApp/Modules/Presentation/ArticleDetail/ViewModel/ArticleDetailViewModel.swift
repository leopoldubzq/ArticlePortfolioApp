import Foundation

protocol ArticleDetailViewModelProtocol: ObservableObject {
    var articleModel: ArticleDto { get set }
}

final class ArticleDetailViewModel: ArticleDetail.ViewModel {
    
    @Published var articleModel: ArticleDto = .init()
    
    // MARK: - Lifecycle
    init(articleData: ArticleDto) {
        self.articleModel = articleData
    }
}


