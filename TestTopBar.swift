import SwiftUI

struct TestTopBar: View {
    @Binding var testState: TestState
    @Binding var manager: TestManager
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 1.0) {
                Text(manager.bestRT, format: .number.precision(.fractionLength(3)))
                    .font(.title)
                    .fontWeight(.bold)
                    .contentTransition(.numericText(value: manager.bestRT))
                
                Text("Best Reaction Time")
                    .font(.title2)
            }
            .multilineTextAlignment(.leading)
            .padding(.leading, 8)
            
            Spacer()
            
            CapsuleButton(text: "house.fill", isCircular: true) { testState = .launch }
        }
        .padding(.top, 4)
        .padding(.horizontal, 8)
    }
}
