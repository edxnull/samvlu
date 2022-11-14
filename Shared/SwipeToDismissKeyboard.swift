//
//  SwipeToDismissKeyboard.swift
//  samvlu
//
//  Created by Edgar Gavrik on 25/03/2022.
//

import SwiftUI

// https://stackoverflow.com/questions/56491386/how-to-hide-keyboard-when-using-swiftui

extension View {
    func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
            to: nil, from: nil, for: nil)
    }
}

struct SwipeToDismissKeyboard: View {
    @State private var text: String = ""
    @State private var placeholderText: String = ""
    @State private var tapped: Bool = false
    
    var body: some View {
        VStack {
            Text("")
            TextEditor(text: $text)
                .frame(width: UIScreen.main.bounds.width - 10, height:300)
                .font(.system(size: 25))
                .border(.gray)
                .onTapGesture {
                    tapped = true
                    placeholderText = ""
                }
                .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onEnded({ v in
                        // NOTE: only work when swiping down
                        if v.translation.height > 0 {
                            self.endEditing()
                        }
                    })
                )
            Spacer()
            Spacer()
        }
    }
}

struct SwipeToDismissKeyboard_Previews: PreviewProvider {
    static var previews: some View {
        SwipeToDismissKeyboard()
    }
}
