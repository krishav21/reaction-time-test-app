import SwiftUI
import Observation

@Observable @MainActor
final class TestManager {
    var stage1Color: Color = .gray
    var stage2Color: Color = .gray
    var stage3Color: Color = .gray
    var stage4Color: Color = .gray
    var stage5Color: Color = .gray
    
    var waitTime: Double = 0
    
    var reactionTime: TimeInterval = 0
    var bestRT: TimeInterval = 0
    
    var hasFailed: Bool = false
    var reactionTimeText: String {
        if !hasFailed {
            return "\(reactionTime.formatted(.number.precision(.fractionLength(3))))"
        } else {
            return "FAIL"
        }
    }
    
    var timer: Timer?
    var timerState: TimerState = .hasNotStarted
    
    var testTask: Task<Void, Never>?
    var hasTestReset: Bool = false
    
    func setTest() {
        testTask = Task {
            do {
                hasTestReset = false
                
                try await Task.sleep(for: .seconds(1))
                try Task.checkCancellation()
                stage1Color = .red
                
                try await Task.sleep(for: .seconds(1))
                try Task.checkCancellation()
                stage2Color = .red
                
                try await Task.sleep(for: .seconds(1))
                try Task.checkCancellation()
                stage3Color = .red
                
                try await Task.sleep(for: .seconds(1))
                try Task.checkCancellation()
                stage4Color = .red
                
                try await Task.sleep(for: .seconds(1))
                try Task.checkCancellation()
                stage5Color = .red
                
                waitTime = .random(in: 2...5)
                try await Task.sleep(for: .seconds(waitTime))
                try Task.checkCancellation()
                
                timer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true) { _ in
                    DispatchQueue.main.async {
                        self.reactionTime += 0.001
                    }
                }
                
                timerState = .started
                resetLights()
            } catch {
                print("Test cancelled.")
            }
        }
    }
    
    func stopTest() {
        if timerState == .hasNotStarted {
            hasFailed = true
            cancelTask()
            timerState = .finished
            resetLights()
        } else if timerState == .started {
            timerState = .finished
            cancelTask()
            setNewBestReactionTime(reactionTime)
        }
    }
    
    private func resetLights() {
        stage1Color = .gray
        stage2Color = .gray
        stage3Color = .gray
        stage4Color = .gray
        stage5Color = .gray
    }
    
    func resetTest() {
        hasFailed = false
        reactionTime = 0
        timerState = .hasNotStarted
        cancelTask()
        resetLights()
        hasTestReset = true
    }
    
    private func cancelTask() {
        timer?.invalidate()
        timer = nil
        testTask?.cancel()
        testTask = nil
    }
    
    private func setNewBestReactionTime(_ reactionTime: TimeInterval) {
        if (bestRT > reactionTime) || (bestRT == 0) {
            bestRT = reactionTime
        }
    }
}
