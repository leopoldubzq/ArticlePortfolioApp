import SwiftUI

struct HiddenNavBarView<Content>: View where Content: View {
    @State private var isBarHidden: Bool = false
    private let content: Content
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body : some View {
        content
            .toolbar(isBarHidden ? .hidden : .visible, for: .navigationBar)
            .navigationBarBackButtonHidden()
            .toolbarBackground(.clear, for: .navigationBar)
            .onAppear {
                isBarHidden = true
            }
    }
}
