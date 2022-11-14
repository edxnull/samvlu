//
//  BasicTableView.swift
//  samvlu
//
//  Created by Edgar Gavrik on 17/03/2022.
//

import SwiftUI

// Build Custom Table View Controller
// Work with Nav Bar Buttons
// Populate Table Rows with local data

extension View {
    static func Dst(_ n: String) -> some View {
        var body: some View {
            VStack {
                Text(n).font(.system(size: 39))
                Spacer()
            }
        }
        return body
    }
}

struct Empty: View {
    var body: some View {
        Text("")
    }
}

struct BasicTableView: View {
    @State private var screenWidth: CGFloat = UIScreen.main.bounds.width
    
    let movieTitle: [String] = [
        "Effing Bingo",
        "The Wood Job",
        "Stranger than Fiction",
        "Breaking Bad",
        "Little Forest 한국어",
        "Little Forest 日本語"
    ]
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 110) {
                Button("Edit") {
                }.padding(.leading)
                    .contextMenu {
                        Button(action: {}) {
                            Text("Share")
                            Image(systemName: "square.and.arrow.up")
                        }
                        
                        Button(action: {}) {
                            Image(systemName: "heart.fill")
                            Text("Favorite")
                        }
                    }
                Text("Movies")
                    .fontWeight(.bold)
                    .font(.system(size: 20))
            }
            .frame(width: screenWidth, height: 20, alignment: .leading)
            Divider()
            NavigationView {
                List {
                    ForEach(movieTitle, id: \.self) { mvt in
                        NavigationLink(mvt, destination: {Empty.Dst(mvt)})
                    }
                }
                .navigationBarHidden(true)
                .listStyle(.plain)
            }
        }
    }
}

struct BasicTableView_Previews: PreviewProvider {
    static var previews: some View {
        BasicTableView()
    }
}
