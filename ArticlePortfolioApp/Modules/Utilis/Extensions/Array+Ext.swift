import Foundation

extension Array where Element: Encodable {
    var encoded: Data {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        let jsonData = try? jsonEncoder.encode(self)
        return jsonData ?? Data()
    }
}
