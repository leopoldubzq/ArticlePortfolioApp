import SwiftUI

protocol ResolverProtocol {
    associatedtype T: View
    func resolveView(with dependencies: DependenciesFactory) -> T
}

//extension ResolverProtocol {
//    func resolveView(dependencies: DependenciesFactory? = nil) -> T {
//        resolveView(dependencies: dependencies)
//    }
//}
