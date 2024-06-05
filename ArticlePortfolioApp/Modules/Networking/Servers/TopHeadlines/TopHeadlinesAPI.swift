import Moya
import Combine

enum TopHeadlinesAPI {
    case topHeadlines
}

extension TopHeadlinesAPI: TargetType {
    var baseURL: URL {
        URL(string: APIEnvironment.baseUrl)!
    }
    
    var path: String {
        "/top-headlines"
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        switch self {
        case .topHeadlines:
            let queryParameters = [
                "language" : "en",
                "pageSize" : "30"
            ]
            return .requestParameters(parameters: queryParameters,
                                      encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        APIEnvironment.headers
    }
    
    var sampleData: Data {
        """
{
"status": "ok",
"totalResults": 10,
"articles": [
    {
        "source": {
        "id": "techcrunch",
        "name": "TechCrunch"
        },
        "author": "Lauren Forristal",
        "title": "Bye-bye bots: Altera's game-playing AI agents get backing from Eric Schmidt | TechCrunch",
        "description": "Autonomous, AI-based players are coming to a gaming experience near you, and a new startup, Altera, is joining the fray to build this new guard of AI Research company Altera raised $9 million to build AI agents that can play video games alongside other player…",
        "url": "https://techcrunch.com/2024/05/08/bye-bye-bots-alteras-game-playing-ai-agents-get-backing-from-eric-schmidt/",
        "urlToImage": "https://techcrunch.com/wp-content/uploads/2024/05/Minecraft-keyart.jpg?resize=1200,720",
        "publishedAt": "2024-05-08T15:14:57Z",
        "content": "Autonomous, AI-based players are coming to a gaming experience near you, and a new startup, Altera, is joining the fray to build this new guard of AI agents.\r\nThe company announced Wednesday that it … [+6416 chars]"
    }]
}
""".dataEncoded
    }
    
}
