import SwiftUI

protocol ArticleDetailRouterLogic: AnyObject {
    func navigate(_ route: ArticleDetailRoute)
}

class DefaultArticleRouter: ArticleDetailRouterLogic {
    public func navigate(_ route: ArticleDetailRoute) {
        assertionFailure()
    }
}

extension EnvironmentValues {
    var articleDetailRouter: ArticleDetailRouterLogic {
        get { self[ArticleDetailRouterKey.self] }
        set { self[ArticleDetailRouterKey.self] = newValue }
    }
}

struct ArticleDetailRouterKey: EnvironmentKey {
    static let defaultValue: ArticleDetailRouterLogic = DefaultArticleRouter()
}

