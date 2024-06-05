import Moya

struct LoggerPlugin {
    private typealias LogConfiguration = NetworkLoggerPlugin.Configuration
    private typealias LogOptions = LogConfiguration.LogOptions
    private typealias LogFormatter = LogConfiguration.Formatter
    private typealias LogOutputType = LogConfiguration.OutputType

    static var `default`: PluginType? {
        #if DEBUG
            let entryFormatter: LogFormatter.EntryFormatterType = logFormatter
            let output: LogOutputType = logOutput
            let options: LogOptions = [LogOptions.requestMethod,
                                       LogOptions.requestHeaders,
                                       LogOptions.requestBody,
                                       LogOptions.errorResponseBody,
                                       LogOptions.successResponseBody]

            let configuration = LogConfiguration(formatter: LogFormatter(entry: entryFormatter),
                                                 output: output,
                                                 logOptions: options)
            return NetworkLoggerPlugin(configuration: configuration)
        #else
            return nil
        #endif
    }

    #if DEBUG
        static func logFormatter(identifier: String, message: String, target _: TargetType) -> String {
            let date = DateFormatter.logEntryDateFormatter.string(from: Date())
            return "\(date) 🌐 \(identifier):\(message)"
        }

        public static func logOutput(target _: TargetType, items: [String]) {
            DispatchQueue.main.async {
                for item in items {
                    DebugLog("\(item)")
                }
            }
        }
    #endif
}
