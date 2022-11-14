//
//  TipCalculator.swift
//  samvlu
//
//  Created by Edgar Gavrik on 14/03/2022.
//

import SwiftUI

struct TipCalculator: View {
    @State private var isEditing = false
    @State private var userInput: String = ""
    @State private var tipPercent: Double = 0.0
    
    private func userInputAsDouble() -> Double {
        if let num = Double(self.userInput.dropFirst()) {
           return num
        }
        return 0.00
    }
    
    private func calcTip() -> String {
        if self.userInput.isEmpty {
            return "0.00"
        }
        if self.userInput.contains("$") {
            return String(format: "%.2f", userInputAsDouble() * (self.tipPercent / 100))
        }
        return ""
    }
    
    private func calcTotal() -> String {
        if let tip = Double(self.calcTip()) {
            return String(
                format: "%.2f",
                self.userInputAsDouble() + tip
            )
        }
        return ""
    }

    private func handleUserInput() {
        if !self.userInput.isEmpty {
            if self.userInput.contains("$") && self.userInput.contains(".") {
                self.userInput = "\(self.userInput)"
            } else if !self.userInput.contains("$") && self.userInput.contains(".") {
                self.userInput = "$\(self.userInput)"
            }
            if self.userInput.contains(".") {
                if let s = self.userInput.lastIndex(of: ".") {
                    let decimalPlaces = self.userInput[self.userInput.index(after: s)...]
                    if decimalPlaces.count == 1 {
                        if self.userInput.contains("$") {
                            self.userInput = "\(self.userInput)0"
                        } else {
                            self.userInput = "$\(self.userInput)0"
                        }
                    }
                } else {
                    self.userInput = "$\(self.userInput)"
                }
            } else {
                self.userInput = "$\(self.userInput).00"
            }
        }
    }
    
    var body: some View {
        VStack {
            Text("Tip Calculator")
                .font(.system(size: 20))
                .bold()
            Divider()
            VStack(alignment: .trailing) {
                HStack {
                    TextField("0.00", text: $userInput)
                        .font(.system(size: 70))
                        .frame(width:300, alignment: .trailing)
                        .padding(.bottom)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.asciiCapable)
                        .disableAutocorrection(true)
                        .onSubmit {
                            handleUserInput()
                        }
                    if !userInput.isEmpty {
                        Button(action: {
                            userInput = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 15, height:15)
                                .scaledToFit()
                                .foregroundColor(.gray)
                                .opacity(0.5)
                        }
                    }
                }
                
                HStack(spacing: 30) {
                    Text("Tip (" + String(format: "%.f", tipPercent) + "%)")
                    Text("$" + calcTip())
                }.font(.system(size:20))
                    .padding(.bottom)
                HStack(spacing: 30) {
                    Text("Total:")
                    Text("$" + calcTotal())
                }.font(.system(size:20))
            }
            .frame(width:370, height:300)
            
            Slider(value: $tipPercent, in: 1...100, step: 1, onEditingChanged: { editing in
                isEditing = editing
            })
                .frame(width:350)
            Text("is Editing: \(isEditing)" as String)
            Spacer()
        }
    }
}

struct TipCalculator_Previews: PreviewProvider {
    static var previews: some View {
        TipCalculator()
    }
}
