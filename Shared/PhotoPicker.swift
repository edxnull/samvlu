//
//  PhotoPicker.swift
//  samvlu
//
//  Created by Edgar Gavrik on 06/07/2022.
//

import SwiftUI

struct PhotoPicker: View {
    @State private var text = """
\"Twelve significant photograps in any one year is a good crop\" \n --Ansel Adams"
"""
    var body: some View {
        VStack {
            HStack{
                Group {
                    Button(action: {}, label: {
                        Image(systemName: "chevron.left")
                    })
                    Spacer()
                    Button(action: {}, label: {
                        Image(systemName: "camera.fill")
                    })
                }
                .padding(30)
                .font(.system(size: 30))
            }
            VStack {
                if #available(iOS 16.0, *) {
                    TextField("", text: $text, axis: .vertical)
                        .frame(width: 400, height: 300, alignment: .topTrailing)
                        .lineLimit(5...10)
                        .padding()
                        .font(.system(size: 27))
                } else {
                    #warning("Fallback: need to handle earlier versions")
                }
            }
            .frame(alignment: .trailing)
            Spacer()
        }
    }
}

struct PhotoPicker_Previews: PreviewProvider {
    static var previews: some View {
        PhotoPicker()
    }
}
