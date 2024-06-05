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
        fetchArticles(with: "apple")
    }
}

final class HomeViewModel: Home.ViewModel {
    
    //MARK: - PRIVATE PROPERTIES
    private let homeService: HomeServerProtocol
    
    //MARK: - PUBLIC PROPERTIES
    @Published var articles: [ArticleDto] = []
    @Published var searchPhrase: String = ""
    
    //MARK: - INITIALIZER
    init(homeServer: HomeServerProtocol) {
        self.homeService = homeServer
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
        homeService
            .fetchArticles(withQuery: query)
            .subscribe(on: DispatchQueue.global(qos: .utility))
            .receive(on: RunLoop.main)
            .map { articleResponse -> [ArticleDto] in
                return articleResponse.articles.filter { $0.imageUrl != nil  }
            }
            .handleLoadingEvents(with: self)
            .catch { error -> AnyPublisher<[ArticleDto], Never> in
//                ToastManager.shared.showToastInTheQueue(with: "Coś poszło nie tak", type: .error)
                return Just([]).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    private func observeSearchPhrase() {
        $searchPhrase
            .removeDuplicates()
            .dropFirst()
            .customDebounce(forSeconds: 0.5)
            .map { query in
                query.isEmpty ? "apple" : query
            }
            .map { [unowned self] query in
                articlesPublisher(query: query)
            }
            .switchToLatest()
            .assign(to: &$articles)
    }
    
    
}
