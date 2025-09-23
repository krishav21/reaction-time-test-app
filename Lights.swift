import SwiftUI

struct Lights: View {
    @Binding var manager: TestManager
    
    var lights: [Color] {
        return [manager.stage1Color, manager.stage2Color, manager.stage3Color, manager.stage4Color, manager.stage5Color]
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 48.0, style: .continuous)
                .frame(width: 480, height: 180)
                .foregroundStyle(.black.opacity(0.75).gradient)
                .shadow(radius: 8, y: 8)
            
            HStack(spacing: 48.0) {
                ForEach(lights, id: \.self) { light in
                    VStack(spacing: 24.0) {
                        Circle()
                            .frame(width: 42)
                        
                        Circle()
                            .frame(width: 42)
                    }
                    .foregroundStyle(light)
                    .shadow(color: light, radius: 4, y: 4)
                }
            }
        }
        .animation(.none, value: lights)
    }
}
