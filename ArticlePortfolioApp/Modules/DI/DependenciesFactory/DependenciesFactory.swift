import SwiftUI

class DependenciesFactory: ObservableObject {
    let homerServer: HomeServer
    
    init() {
        homerServer = HomeServer()
    }
}
