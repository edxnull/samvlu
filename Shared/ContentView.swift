//
//  ContentView.swift
//  Shared
//
//  Created by Edgar Gavrik on 14/03/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        if #available(iOS 16.0, *) {
            PhotoPicker()
        } else {
            // Fallback on earlier versions
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
