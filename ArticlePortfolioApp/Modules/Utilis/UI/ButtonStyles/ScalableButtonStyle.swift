import SwiftUI

struct ScalableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .opacity(configuration.isPressed ? 0.7 : 1)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}
