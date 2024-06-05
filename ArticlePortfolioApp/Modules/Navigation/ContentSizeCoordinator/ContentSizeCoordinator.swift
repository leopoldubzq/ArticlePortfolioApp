import SwiftUI

final class ContentSizeCoordinator: ObservableObject {
    @Published var presentationDetents: Set<PresentationDetent> = []
}
