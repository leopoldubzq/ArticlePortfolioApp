import Foundation

extension String {
    var dataEncoded: Data {
        self.data(using: String.Encoding.utf8)!
    }
}
