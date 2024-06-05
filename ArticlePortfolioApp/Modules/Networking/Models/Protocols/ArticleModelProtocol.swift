import Foundation

protocol ArticleModelProtocol: Hashable {
    var createdAt: Date { get }
    var title: String? { get }
    var articleDescription: String? { get }
    var articleUrl: URL? { get }
    var imageUrl: URL? { get }
}
