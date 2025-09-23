import SwiftUI

struct CapsuleButton: View {
    var text: String
    var isCircular: Bool
    var action: () throws -> Void
    
    var body: some View {
        Button {
            withAnimation(.smooth) { try? action() }
        } label: {
            Group {
                if isCircular {
                    Image(systemName: text)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .padding(10)
                } else {
                    Text(text)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .padding(12)
                        .padding(.horizontal, 120)
                }
            }
        }
        .padding(isCircular ? 8 : 16)
        .buttonStyle(BouncyButtonStyle())
    }
}

struct BouncyButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? .orange.opacity(0.75) : .orange, in: .capsule)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.00)
            .animation(.spring, value: configuration.isPressed)
    }
}
