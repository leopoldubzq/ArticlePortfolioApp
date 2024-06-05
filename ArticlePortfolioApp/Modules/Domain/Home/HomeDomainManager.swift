import Combine
import Moya

protocol HomeDomainManagerProtocol {
    func fetchArticles(withQuery query: String) -> AnyPublisher<[ArticleDto], MoyaError>
}

extension HomeDomainManagerProtocol {
    func fetchArticles(withQuery query: String) -> AnyPublisher<[ArticleDto], MoyaError> {
        fetchArticles(withQuery: "")
    }
}

final class HomeDomainManager: HomeDomainManagerProtocol {
    
    private let everythingServer: EverythingServerProtocol
    private let topHeadlinesServer: TopHeadlinesServerProtocol
    
    init(everythingServer: EverythingServerProtocol,
         topHeadlinesServer: TopHeadlinesServerProtocol) {
        self.everythingServer = everythingServer
        self.topHeadlinesServer = topHeadlinesServer
    }
    
    convenience init(statusCode: StatusCode?) {
        self.init(everythingServer: EverythingServer(provider: .getMockProvider(withStatusCode: statusCode!)),
                  topHeadlinesServer: TopHeadlinesServer(provider: .getMockProvider(withStatusCode: statusCode!)))
        
    }
    
    func fetchArticles(withQuery query: String) -> AnyPublisher<[ArticleDto], MoyaError> {
        if query.isEmpty {
            return fetchTopHeadlines()
        } else {
            return fetchEverything(withQuery: query)
        }
    }
    
    private func fetchTopHeadlines() -> AnyPublisher<[ArticleDto], MoyaError> {
        topHeadlinesServer.fetchTopHeadlines()
            .subscribe(on: DispatchQueue.global(qos: .utility))
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    private func fetchEverything(withQuery query: String) -> AnyPublisher<[ArticleDto], MoyaError> {
        everythingServer.fetchArticles(withQuery: query)
            .subscribe(on: DispatchQueue.global(qos: .utility))
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
}
