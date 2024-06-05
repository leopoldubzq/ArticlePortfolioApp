import SwiftUI

struct PresentationDetentsModifier: ViewModifier {
    
    var presentationDetents: Set<PresentationDetent>
    
    init(_ presentationDetents: Set<PresentationDetent>) {
        self.presentationDetents = presentationDetents
    }
    
    func body(content: Content) -> some View {
        if presentationDetents.isEmpty {
            content
        } else {
            content
                .presentationDetents(presentationDetents)
        }
    }
}
