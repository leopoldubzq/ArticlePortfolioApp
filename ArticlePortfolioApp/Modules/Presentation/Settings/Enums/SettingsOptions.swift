enum SettingsOptions {
    enum General: CaseIterable {
        case account
        case language
        
        var title: String {
            switch self {
            case .account:
                return "Account"
            case .language:
                return "Language"
            }
        }
    }
    enum Appearance: CaseIterable {
        case theme
        
        var title: String {
            switch self {
            case .theme:
                return "Theme"
            }
        }
    }
    enum Account: CaseIterable {
        case deleteAccount
        
        var title: String {
            switch self {
            case .deleteAccount:
                return "Delete account"
            }
        }
    }
}
