import Foundation

func DebugLog(file: String = #file,
                function: String = #function,
                line: Int = #line,
                _ message: String) {
    #if DEBUG
        Logger.log(file: file, function: (function, line), logLevel: .debug, message: message)
    #endif
}

func InfoLog(file: String = #file,
               function: String = #function,
               line: Int = #line,
               _ message: String) {
    #if DEBUG
        Logger.log(file: file, function: (function, line), logLevel: .info, message: message)
    #endif
}

func WarningLog(file: String = #file,
                  function: String = #function,
                  line: Int = #line,
                  _ message: String) {
    #if DEBUG
        Logger.log(file: file, function: (function, line), logLevel: .warning, message: message)
    #endif
}

func ErrorLog(file: String = #file,
                function: String = #function,
                line: Int = #line,
                _ message: String) {
    #if DEBUG
        Logger.log(file: file, function: (function, line), logLevel: .error, message: message)
    #endif
}

class Logger: NSObject {
    static let shared = Logger()

    class func log(file: String, function: (String, Int), logLevel: LogLevel, message: String) {
        let className = URL(fileURLWithPath: file).lastPathComponent.replacingOccurrences(of: ".swift", with: "")
        let dateStr = DateFormatter.logEntryDateFormatter.string(from: Date())
        let logMessage = "\(className).\(function.0) line:\(function.1) \(logLevel.toString()) \(message)"
        log("\(dateStr) \(logMessage)")
    }

    class func log(_ message: String) {
        print(message)
    }
}
