import SwiftUI

struct TestView: View {
    @Binding var testState: TestState
    @State private var manager: TestManager = .init()
    
    @AppStorage("bestReactionTime") private var bestReactionTime: TimeInterval = 0
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            Text(manager.reactionTimeText)
                .foregroundStyle(!manager.hasFailed ? .white : .red)
                .font(.largeTitle)
                .fontWeight(.black)
                .contentTransition(.numericText(value: manager.reactionTime))
                .padding()
            
            Lights(manager: $manager)
            
            Spacer()
            
            CapsuleButton(text: !manager.hasTestReset ? "Reset" : "Start", isCircular: false) { 
                if !manager.hasTestReset {
                    manager.resetTest()
                } else {
                    manager.setTest()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .top) { TestTopBar(testState: $testState, manager: $manager) }
        .contentShape(Rectangle())
        .background(.ultraThinMaterial)
        .onTapGesture { if manager.timerState != .finished { manager.stopTest() } }
        .onChange(of: manager.bestRT) { bestReactionTime = manager.bestRT }
        .onAppear {
            if manager.timerState != .finished { manager.setTest() }
            manager.bestRT = bestReactionTime
        }
    }
}
