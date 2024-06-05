import Moya
import Combine

protocol TopHeadlinesServerProtocol {
    func fetchTopHeadlines() -> AnyPublisher<[ArticleDto], MoyaError>
}

final class TopHeadlinesServer: TopHeadlinesServerProtocol {

    private let provider: MoyaProvider<TopHeadlinesAPI>
    
    init(provider: MoyaProvider<TopHeadlinesAPI> = MoyaProvider<TopHeadlinesAPI>.default) {
        self.provider = provider
    }
    
    func fetchTopHeadlines() -> AnyPublisher<[ArticleDto], MoyaError> {
        provider
            .requestPublisher(.topHeadlines)
            .filterSuccessfulStatusAndRedirectCodes()
            .map(ArticleResponseDto.self)
            .map(\.articles)
            .eraseToAnyPublisher()
    }
    
    
}
