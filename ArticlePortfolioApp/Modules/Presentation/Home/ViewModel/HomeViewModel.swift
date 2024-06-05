import SwiftUI
import Combine
import Moya

protocol HomeViewModelProtocol: ObservableObject {
    var articles: [ArticleDto] { get set }
    var searchPhrase: String { get set }
    func fetchArticles(with query: String)
}

extension HomeViewModelProtocol {
    func fetchArticles(with query: String = "") {
        fetchArticles(with: "")
    }
}

final class HomeViewModel: Home.ViewModel {
    
    //MARK: - PRIVATE PROPERTIES
    private let homeDomainManager: HomeDomainManagerProtocol
    
    //MARK: - PUBLIC PROPERTIES
    @Published var articles: [ArticleDto] = []
    @Published var searchPhrase: String = ""
    
    //MARK: - INITIALIZER
    init(homeDomainManager: HomeDomainManagerProtocol) {
        self.homeDomainManager = homeDomainManager
        super.init()
        observeSearchPhrase()
    }
    
    deinit {
        print("\(String(describing: self)) deinitialized")
    }
    
    //MARK: - PUBLIC METHODS
    func fetchArticles(with query: String = "") {
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
    
    private func observeSearchPhrase() {
        $searchPhrase
            .removeDuplicates()
            .dropFirst()
            .customDebounce(forSeconds: 0.5)
            .map { [unowned self] query in
                articlesPublisher(query: query)
            }
            .switchToLatest()
            .assign(to: &$articles)
    }
    
    
}
