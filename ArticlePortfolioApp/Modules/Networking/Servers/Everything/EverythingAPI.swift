import Moya

enum EverythingAPI {
    case everything(String)
}

extension EverythingAPI: TargetType {
    var baseURL: URL {
        URL(string: APIEnvironment.baseUrl)!
    }
    
    var path: String {
        "/everything"
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        switch self {
        case .everything(let query):
            let queryParameters = [
                "language" : "en",
                "q" : query,
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
        switch self {
        case .everything:
"""
{
"status": "ok",
"totalResults": 1728,
"articles": [
    {
        "source": {
            "id": null,
            "name": "Yahoo Entertainment"
        },
        "author": "Lawrence Bonk",
        "title": "VR classics Job Simulator and Vacation Simulator come to Apple Vision Pro",
        "description": "The Apple Vision Pro was marketed primarily as a productivity machine, but as any active VR user can tell you, it’s the games that sell these devices. Apple’s headset offers access to hundreds of games, but mostly as quick and dirty iPad ports that show up as…",
        "url": "https://consent.yahoo.com/v2/collectConsent?sessionId=1_cc-session_6a6ab0dd-00f8-4399-ad8d-1d7bc76dd1bb",
        "urlToImage": "https://cdn.vox-cdn.com/thumbor/lJEbJWuLwU6Pm1J_R-PH_uAcAu0=/0x0:3840x1918/1200x628/filters:focal(1920x959:1921x960)/cdn.vox-cdn.com/uploads/chorus_asset/file/25470597/Pachinko_203_F00314F.jpg",
        "publishedAt": "2024-05-28T19:05:45Z",
        "content": "If you click 'Accept all', we and our partners, including 237 who are part of the IAB Transparency &amp; Consent Framework, will also store and/or access information on a device (in other words, use … [+678 chars]"
    }
]
}
""".dataEncoded
        }
    }
}
