import Foundation

struct ArticleDto: Codable, Hashable, ArticleModelProtocol {
    var title: String?
    var articleDescription: String?
    var articleUrl: URL?
    var imageUrl: URL?
    
    enum CodingKeys: String, CodingKey {
        case title
        case articleDescription = "description"
        case articleUrl = "url"
        case imageUrl = "urlToImage"
    }
    
    static var mock: Self {
        .init(title: "VR classics Job Simulator and Vacation Simulator come to Apple Vision Pro",
              articleDescription: "The Apple Vision Pro was marketed primarily as a productivity machine, but as any active VR user can tell you, it’s the games that sell these devices. Apple’s headset offers access to hundreds of games, but mostly as quick and dirty iPad ports that show up as…",
              articleUrl: URL(string: "https://consent.yahoo.com/v2/collectConsent?sessionId=1_cc-session_6a6ab0dd-00f8-4399-ad8d-1d7bc76dd1bb"),
              imageUrl: URL(string: "https://cdn.vox-cdn.com/thumbor/lJEbJWuLwU6Pm1J_R-PH_uAcAu0=/0x0:3840x1918/1200x628/filters:focal(1920x959:1921x960)/cdn.vox-cdn.com/uploads/chorus_asset/file/25470597/Pachinko_203_F00314F.jpg"))
    }
}
