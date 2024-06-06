import Foundation

extension Data {
    func decodeToArray<T: Decodable>() -> [T] {
        let jsonDecoder = JSONDecoder()
        let decodedArray = try? jsonDecoder.decode([T].self, from: self)
        return decodedArray ?? []
    }
    
    func decode<T: Decodable>() -> T? {
        let jsonDecoder = JSONDecoder()
        let decodedArray = try? jsonDecoder.decode(T.self, from: self)
        return decodedArray
    }
}
