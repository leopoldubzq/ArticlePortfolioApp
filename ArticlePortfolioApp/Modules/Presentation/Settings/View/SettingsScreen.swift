import SwiftUI

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

struct SettingsScreen<ViewModel: Settings.ViewModel>: View {
    
    @StateObject var viewModel: ViewModel
    @Environment(\.settingsScreenRouter) private var router: SettingsScreenRouterLogic
    
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        List {
            Section("General") {
                ForEach(SettingsOptions.General.allCases, id: \.self) { option in
                    Button(option.title) { router.navigate(.settingDetails(option.title)) }
                        .tint(.primary)
                }
            }
            
            Section("Appearance") {
                ForEach(SettingsOptions.Appearance.allCases, id: \.self) { option in
                    Button(option.title) { router.navigate(.settingDetails(option.title)) }
                        .tint(.primary)
                }
            }
            
            Section {
                ForEach(SettingsOptions.Account.allCases, id: \.self) { option in
                    Button(option.title) {}
                        .tint(.red)
                }
            }
        }
        .navigationTitle("Settings")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Close") {
                    router.navigate(.back)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SettingsScreen(viewModel: SettingsViewModel())
    }
}
