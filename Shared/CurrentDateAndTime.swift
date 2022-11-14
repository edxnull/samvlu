//
//  CurrentDateAndTime.swift
//  samvlu
//
//  Created by Edgar Gavrik on 19/03/2022.
//

import SwiftUI

struct CurrentDateAndTime: View {
    @State private var date: Date = Date()
    @State private var refresh: Bool = false
    let dateFormatter: DateFormatter
    
    init() {
        // TODO: Learn more about dates
        // https://benoitpasquier.com/date-formatter-swiftui/
        dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .medium
    }
    var body: some View {
        VStack {
            // NOTE: This is one way of doing this, but if we want more control
            // then we should use DateFormatter
            Group {
                // HStack(spacing: 20) {
                //    Text(Date(), style: .date)
                //    Text(Date(), style: .time)
                // }
                Text(date, formatter: dateFormatter)
                // TODO: opacity animations: https://shorturl.at/goCPR
            .font(.system(size: 25, weight: .light, design: .rounded))
            .padding(5)
            
            Button("Refresh") {
                date = Date()
                refresh.toggle()
            }.font(.system(size: 20))
                .buttonStyle(.bordered)
                .cornerRadius(20)
            }
        }
    }
}

struct CurrentDateAndTime_Previews: PreviewProvider {
    static var previews: some View {
        CurrentDateAndTime()
        // NOTE: and this is how we set up a flocale with identifiers like
        // "fr", "ru", "lv", "lt", "en", "uk", "zh", "ja", "ko"
            .environment(\.locale, Locale(identifier:"zh"))
    }
}
