import Moya

extension MoyaProvider {
    
    static var `default`: MoyaProvider {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.timeoutIntervalForRequest = Constants.defaultHttpsTimeoutInSeconds
        let session = Session(configuration: configuration)
        return MoyaProvider(session: session,
                            plugins: [LoggerPlugin.default].compactMap { $0 })
    }
    
    static func getMockProvider<T: TargetType>(withStatusCode statusCode: StatusCode) -> MoyaProvider<T> {
        let serverSuccessEndpointClosure = { (target: T) -> Endpoint in
            return Endpoint(
                url: target.baseURL.appendingPathComponent(target.path).absoluteString,
                sampleResponseClosure: { .networkResponse(statusCode.rawValue, target.sampleData) },
                method: target.method,
                task: target.task,
                httpHeaderFields: target.headers
            )
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.timeoutIntervalForRequest = Constants.defaultHttpsTimeoutInSeconds
        
        let session = Session(configuration: configuration,
                              rootQueue: .main,
                              requestQueue: .main,
                              serializationQueue: .main)
        
        return MoyaProvider<T>(
            endpointClosure: serverSuccessEndpointClosure,
            stubClosure: { _ in .immediate },
            session: session
        )
    }
}
