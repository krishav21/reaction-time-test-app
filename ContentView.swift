import SwiftUI

struct ContentView: View {
    @State private var testState: TestState = .launch
    
    var body: some View {
        VStack(spacing: 4.0) {
            Group {
                switch testState {
                case .launch:
                    LaunchView(testState: $testState)
                case .test:
                    TestView(testState: $testState)
                }
            }
        }
        .fontWidth(.condensed)
        .textCase(.uppercase)
        .multilineTextAlignment(.center)
    }
}
