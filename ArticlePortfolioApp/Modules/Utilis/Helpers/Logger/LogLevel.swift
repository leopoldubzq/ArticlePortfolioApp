import Foundation

/// Define log level
enum LogLevel: Int, Comparable, CaseIterable {
    /// No logs - default
    case none = 0
    /// Error logs only
    case error = 1
    /// Enable warning logs
    case warning = 2
    /// Enable info logs
    case info = 3
    /// Enable all logs
    case debug = 4

    func toString() -> String {
        switch self {
        case .none:
            return ""
        case .error:
            return "👺"
        case .warning:
            return "🙀"
        case .info:
            return "🤖"
        case .debug:
            return "🗣"
        }
    }

    static func < (lhs: LogLevel, rhs: LogLevel) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}
