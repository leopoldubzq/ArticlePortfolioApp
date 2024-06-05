import Moya
import Combine

protocol HomeServerProtocol {
    func fetchArticles(withQuery query: String) -> AnyPublisher<ArticleResponseDto, MoyaError>
}

final class HomeServer: HomeServerProtocol {
    
    private let provider: MoyaProvider<HomeAPI>
    
    init(provider: MoyaProvider<HomeAPI> = MoyaProvider<HomeAPI>.default) {
        self.provider = provider
    }
    
    func fetchArticles(withQuery query: String) -> AnyPublisher<ArticleResponseDto, MoyaError> {
        provider
            .requestPublisher(.everything(query))
            .filterSuccessfulStatusAndRedirectCodes()
            .map(ArticleResponseDto.self)
    }
}
