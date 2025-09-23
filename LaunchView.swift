import SwiftUI

struct LaunchView: View {
    @Binding var testState: TestState
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Reaction Time Test")
                .font(.largeTitle)
                .fontWeight(.black)
            
            Text("Lights out and away we go!")
                .font(.title2)
            
            Spacer()
            
            CapsuleButton(text: "Start") { testState = .test }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.ultraThinMaterial)
    }
}
