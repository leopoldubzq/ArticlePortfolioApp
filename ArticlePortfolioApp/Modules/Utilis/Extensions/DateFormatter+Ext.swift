import Foundation

extension DateFormatter {
    convenience init(dateFormat: String, timeZone: TimeZone = TimeZone.current, locale: Locale = Locale(identifier: "en_US_POSIX")) {
        self.init()
        self.dateFormat = dateFormat
        self.locale = locale
        self.timeZone = timeZone
    }

    static var logEntryDateFormatter = DateFormatter(dateFormat: "yyyy-MM-dd HH:mm:ss.SSSS")
    static var backendDateFormatter = DateFormatter(dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
    static var day = DateFormatter(dateFormat: "d")
    static var month = DateFormatter(dateFormat: "MMM")
    static var hourWithAMPM = DateFormatter(dateFormat: "HH:mm a")

    static func utcTimezoneWithOffsetFormatter(timezone: TimeZone) -> DateFormatter {
        DateFormatter(dateFormat: "OOOO", timeZone: timezone, locale: Locale.current)
    }
}
