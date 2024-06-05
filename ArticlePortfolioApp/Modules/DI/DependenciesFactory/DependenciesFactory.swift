import SwiftUI

class DependenciesFactory: ObservableObject {
    let everythingServer: EverythingServerProtocol
    let topHeadlinesServer: TopHeadlinesServerProtocol
    let homeDomainManager: HomeDomainManagerProtocol
    
    init() {
        everythingServer = EverythingServer()
        topHeadlinesServer = TopHeadlinesServer()
        homeDomainManager = HomeDomainManager(everythingServer: everythingServer, topHeadlinesServer: topHeadlinesServer)
    }
}
