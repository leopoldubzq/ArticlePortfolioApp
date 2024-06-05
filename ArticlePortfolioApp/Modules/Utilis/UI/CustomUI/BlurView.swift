import SwiftUI

struct BlurView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VisualEffectView(effect: UIBlurEffect(style: colorScheme == .dark ? .dark : .light))
    }
}
