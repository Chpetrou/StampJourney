//
//  StampGroupViewCellHelper.swift
//  StampJourney
//
//  Created by Chris Petrou on 13/5/21.
//

import SwiftUI

/// The design of the date label  in stamp group cells
struct DateEnclosure: View {
    var fromToDate: Int
    var fontSize: CGFloat = 12.0

    var body: some View {
        ZStack {
            Text("\(fromToDate)")
                .font(.system(size: fontSize, weight: .regular))
                .lineLimit(2)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.green)
                .cornerRadius(5)
        }
    }
}

/// The design of the country label in stamp group cells
struct CountryEnclosure<Content: View>: View {
    var fontSize: CGFloat = 12.0

    let content: () -> Content

    var body: some View {
        ZStack {
            self.content()
                .font(.system(size: fontSize, weight: .regular))
                .lineLimit(2)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.blue)
                .cornerRadius(5)
        }
    }

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
}
