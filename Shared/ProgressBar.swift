//
//  ProgressBar.swift
//  samvlu
//
//  Created by Edgar Gavrik on 29/03/2022.
//

import SwiftUI

// TODO: https://blckbirds.com/post/progress-bars-in-swiftui/

struct ProgressBar: View {
    @State private var currentProgress: CGFloat = 0.0
    @State private var timerDone: Bool = false
    @State private var running: Bool = false
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(
                        .init(.sRGB, red: 0.30, green: 0.30, blue: 0.30, opacity: 0.212)
                    )
                    .frame(width: 300, height: 20)
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.blue)
                    .frame(width: 300*currentProgress, height: 20)
            }
            Button(action: {
                if !running {
                    self.startLoading()
                    running = true
                }
                if timerDone {
                    self.currentProgress = 0.0
                    timerDone = false
                }
            }) {
                Text("Start timer!")
            }
            Text("\(300*currentProgress)")
            Text("\(currentProgress)")
            Text("\(String(timerDone))")
        }
    }
    
    func startLoading() {
        _ = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            withAnimation() {
                self.currentProgress += 0.01
                if self.currentProgress >= 1.0 {
                    timer.invalidate()
                    timerDone = true
                    running = false
                }
            }
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar()
    }
}
