//
//  PassDataToAnotherView.swift
//  samvlu
//
//  Created by Edgar Gavrik on 24/03/2022.
//

import SwiftUI

struct TextEditorModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: UIScreen.main.bounds.width - 10, height:300)
            .font(.system(size: 25))
    }
}

struct FirstView: View {
    @State private var screenWidth: CGFloat = UIScreen.main.bounds.width
    @State private var userInput: String = ""
    @State private var tapped: Bool = false
    @State private var placeholderText: String = "Please enter some text here"
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .center, spacing: 90) {
                    Text("First View")
                    NavigationLink(
                        destination: SecondView(data: $userInput)
                            .navigationBarHidden(true)
                            .navigationBarBackButtonHidden(true),
                        label: {
                            Text("Done")
                        }
                    )
                    .frame(width: 60, height: 30, alignment: .leading)
                }.frame(width: screenWidth, height:30, alignment: .trailing).font(.system(size: 20))
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                TextEditor(text: placeholderText.isEmpty ? $userInput: $placeholderText)
                    .modifier(TextEditorModifier())
                    .foregroundColor(tapped ? .none : .gray)
                    .opacity(tapped ? 1: 0.5)
                    .onTapGesture {
                        tapped = true
                        placeholderText = ""
                    }
                Divider()
                Spacer()
            }
        }
    }
}

struct SecondView: View {
    @Binding var data: String
    @State private var screenWidth: CGFloat = UIScreen.main.bounds.width
    var body: some View {
        NavigationView {
            VStack {
                HStack(spacing: 50) {
                    Group {
                        NavigationLink(
                            destination: FirstView()
                                .navigationBarHidden(true)
                                .navigationBarBackButtonHidden(true),
                            label: {
                                HStack(spacing: 2) {
                                    Image(systemName: "chevron.backward")
                                        .font(.system(size: 20))
                                    Text("Back")
                                }
                            }
                        ).padding(.leading).navigationBarHidden(true)
                        Text("Second View")
                    }
                    .font(.system(size: 20))
                }.frame(width: screenWidth, height:30, alignment: .leading)
                Divider()
                Text(data)
                    .frame(width: screenWidth - 10, alignment: .leading)
                    .font(.system(size: 25))
                Spacer()
            }
        }
    }
}

struct PassDataToAnotherView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
