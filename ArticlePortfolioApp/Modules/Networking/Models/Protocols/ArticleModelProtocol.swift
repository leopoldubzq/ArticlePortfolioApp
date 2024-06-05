import Foundation

protocol ArticleModelProtocol: Hashable {
    var title: String? { get }
    var articleDescription: String? { get }
    var articleUrl: URL? { get }
    var imageUrl: URL? { get }
}
