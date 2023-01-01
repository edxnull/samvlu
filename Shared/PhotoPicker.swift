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
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var sItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    var body: some View {
        VStack {
            HStack{
                Group {
                    Button(action: {}, label: {
                        Image(systemName: "chevron.left")
                    })
                    Spacer()
                    PhotosPicker(selection: $sItem, matching: .images) {
                        Image(systemName: "camera.fill")
                    }
                    .onChange(of: sItem) { newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                selectedImageData = data
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
                if let selectedImageData, let uiImage = UIImage(data: selectedImageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350, height: 350)
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
