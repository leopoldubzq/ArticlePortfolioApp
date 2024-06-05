import Moya
import Combine

protocol EverythingServerProtocol {
    func fetchArticles(withQuery query: String) -> AnyPublisher<[ArticleDto], MoyaError>
}

final class EverythingServer: EverythingServerProtocol {
    
    private let provider: MoyaProvider<EverythingAPI>
    
    init(provider: MoyaProvider<EverythingAPI> = MoyaProvider<EverythingAPI>.default) {
        self.provider = provider
    }
    
    func fetchArticles(withQuery query: String) -> AnyPublisher<[ArticleDto], MoyaError> {
        provider
            .requestPublisher(.everything(query))
            .filterSuccessfulStatusAndRedirectCodes()
            .map(ArticleResponseDto.self)
            .map(\.articles)
            .eraseToAnyPublisher()
    }
}
