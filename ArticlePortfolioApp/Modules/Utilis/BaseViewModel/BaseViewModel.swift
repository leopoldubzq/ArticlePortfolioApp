import SwiftUI
import Combine

class BaseViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    @Published var isLoading: Bool = false
    
    func showLoader() {
        isLoading = true
    }
    
    func hideLoader() {
        isLoading = false
    }
}
