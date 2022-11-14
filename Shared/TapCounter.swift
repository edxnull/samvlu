//
//  TapCounter.swift
//  samvlu
//
//  Created by Edgar Gavrik on 14/03/2022.
//

import SwiftUI

// unused
func increment(_ num: inout Int) { num = num + 1 }

func randomColor() -> Color {
    return Color(
        red:   Double(Int.random(in: 1...99)) / 100,
        green: Double(Int.random(in: 1...99)) / 100,
        blue:  Double(Int.random(in: 1...99)) / 100
    )
}

struct TapCounter: View {
    @State private var tapCounter: Int = 0
    @State private var isPressed: Bool = false
    
    // let timer = Timer.publish(every: 0.8, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 110) {
                Button("Reset") {
                    tapCounter = 0
                }.foregroundColor(.blue)
                Text("Counter").bold()
                    .font(.system(size: 20))
            }.frame(
                minWidth: 0,
                maxWidth: .infinity,
                alignment: .leading
            ).padding(8)
            
            Spacer()
            VStack(spacing: 40) {
                withAnimation(.linear(duration:3)) {
                    Text(String(tapCounter))
                        .font(.system(size: 80))
                        .fontWeight(.light)
                        .frame(width: 200, height: 120)
                        .padding()
                        .foregroundColor(randomColor())
                }
                Button("Tap or Hold") {
                    tapCounter += 1
                }.foregroundColor(.blue).font(.system(size: 30))
                    .simultaneousGesture(
                        DragGesture(minimumDistance: 0.1)
                            .onChanged({ _ in
                                isPressed = true
                                tapCounter += 1
                            })
                            
                            .onEnded({ _ in
                                isPressed = false
                            })
                    )
//                    .onReceive(timer) { _ in
//                        if isPressed {
//                            tapCounter += 1
//                        }
//                    }
            }
            Spacer()
            Text("\(isPressed ? "Button Pressed" : "Button Released")")
        }
    }
}

struct TapCounter_Previews: PreviewProvider {
    static var previews: some View {
        TapCounter()
    }
}
