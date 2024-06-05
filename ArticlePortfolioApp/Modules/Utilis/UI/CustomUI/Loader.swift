import SwiftUI

struct Loader: View {
    
    var title: String = "Loading"
    
    var body: some View {
        ProgressView(title)
            .tint(.accent)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(.background)
                    .shadow(color: .black.opacity(0.1), radius: 4)
                    
            )
    }
}

#Preview {
    Loader()
}
