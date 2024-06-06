import SwiftUI
import Combine

protocol HomeViewModelProtocol {
    var articles: [ArticleDto] { get set }
    func fetchArticles(withQuery query: String)
}

extension HomeViewModelProtocol {
    func fetchArticles(withQuery query: String) {
        fetchArticles(withQuery: "")
    }
}

final class HomeViewModel: Home.ViewModel {
    
    //MARK: - PUBLIC PROPERTIES
    @Published var articles: [ArticleDto] = []
    
    //MARK: - PRIVATE PROPERTIES
    private let homeDomainManager: HomeDomainManagerProtocol
    
    //MARK: - INITIALIZER
    override init() {
        self.homeDomainManager = HomeDomainManager(everythingServer: EverythingServer(),
                                                   topHeadlinesServer: TopHeadlinesServer())
        super.init()
    }
    
    //MARK: - PUBLIC METHODS
    func isFavourite(model: any ArticleModelProtocol, 
                     favouriteArticles: [ArticleSwiftDataModel]) -> Bool {
        let isFavourite = getFavouriteArticle(model: model, favouriteArticles: favouriteArticles) != nil
        return isFavourite
    }
    
    func fetchArticles(withQuery query: String = "") {
        articlesPublisher(query: query)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] articles in
                self?.articles = articles
            })
            .store(in: &subscriptions)
    }
    
    //MARK: - PRIVATE METHODS
    private func articlesPublisher(query: String) -> AnyPublisher<[ArticleDto], Never> {
        homeDomainManager
            .fetchArticles(withQuery: query)
            .map { $0.filter { $0.imageUrl != nil } }
            .handleLoadingEvents(with: self)
            .catch { error -> AnyPublisher<[ArticleDto], Never> in
                Just([]).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    private func getFavouriteArticle(model: any ArticleModelProtocol,
                                     favouriteArticles: [ArticleSwiftDataModel]) -> ArticleSwiftDataModel? {
        return favouriteArticles.first { article in
            article.checkIfFavourite(modelToCompare: model)
        }
    }
}
