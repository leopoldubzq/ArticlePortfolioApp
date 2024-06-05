enum StatusCode: Int {
    case ok = 200
    case created = 201
    case accepted = 202
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case unprocessableEntity = 422
    case internalServerError = 500
    case badGateway = 502
    case unknown = 999
}
