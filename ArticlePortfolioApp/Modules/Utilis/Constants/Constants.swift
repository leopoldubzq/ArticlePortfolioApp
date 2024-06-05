import Foundation

struct Constants {
    static let defaultHttpsTimeoutInSeconds: TimeInterval = 15.0
    static var isRunningTests: Bool {
        ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    }
}
