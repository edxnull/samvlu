//
//  PhotoPicker.swift
//  samvlu
//
//  Created by Edgar Gavrik on 06/07/2022.
//

import SwiftUI
import PhotosUI

@available(iOS 16.0, *)
struct PhotoPicker: View {
    @State private var text = "\"Twelve significant photograps in any one year is a good crop\" \n --Ansel Adams\""
    @State private var selectedItems: [Data] = []
    @State private var sItem: PhotosPickerItem? = nil
    var body: some View {
        VStack {
            HStack{
                Group {
                    Button(action: {
                        selectedItems.removeAll()
                    }, label: {
                        Image(systemName: "chevron.left")
                    })
                    Spacer()
                    PhotosPicker(selection: $sItem, matching: .images) {
                        Image(systemName: "camera.fill")
                    }
                    .onChange(of: sItem) { _ in
                        Task {
                            if let data = try? await sItem?.loadTransferable(type: Data.self) {
                                selectedItems.append(data)
                            }
                        }
                    }
                }
                .padding(30)
                .font(.system(size: 30))
            }
            
            VStack {
                TextField("", text: $text, axis: .vertical)
                    .frame(width: 400, height: 100, alignment: .topTrailing)
                    .lineLimit(5...10)
                    .padding()
                    .font(.system(size: 27))
                ScrollView {
                    ForEach($selectedItems, id: \.self) {
                        if let img = UIImage(data: $0.wrappedValue) {
                            Image(uiImage: img)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 350, height: 250)
                        }
                    }
                }
            }
            .frame(alignment: .trailing)
            Spacer()
        }
    }
}

struct PhotoPicker_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 16.0, *) {
            PhotoPicker()
        } else {
            // Fallback on earlier versions
        }
    }
}
