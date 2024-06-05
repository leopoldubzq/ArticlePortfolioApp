final class APIEnvironment {
    static let baseUrl = "https://newsapi.org/v2"
    
    private static let apiKey: String = "e67feb25e08e407e849b906912f0eb70"
    
    static let headers: [String : String]? = [
        "application/json" : "Content-Type",
        "X-Api-Key" : apiKey
    ]
}
