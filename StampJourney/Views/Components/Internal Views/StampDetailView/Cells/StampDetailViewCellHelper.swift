//
//  StampDetailViewCellHelper.swift
//  StampJourney
//
//  Created by Chris Petrou on 13/5/21.
//

import SwiftUI

/// Builds a table view with equally spaced text.
///
/// - Parameters:
///   - cellListInfo: The array of sets of information to be shown.
///   - splitAt: The number that the columns are to be divided.
struct DetailsCellTable: View {
    var cellListInfo: [(desc: String, text: String)]
    let splitAt: Int

    var body: some View {
        HStack(alignment: .top) {
            ForEach(Array(zip(cellListInfo.indices, cellListInfo)), id: \.0) { (index, set) in

                if index % splitAt == 0 {
                    DetailInfoColumn(cellListInfo: cellListInfo, splitAt: splitAt, outerIndex: index) { _, set in
                        DetailsCellInfo(description: set.desc, text: set.text)
                            .padding(.bottom, 5)
                    }
                }
            }
        }
    }
}

/// The inner workings of the DetailsCellTable.
///
/// Checks if the information cell is allowed to be placed and adds it.
struct DetailInfoColumn<Content: View>: View {
    var cellListInfo: [(desc: String, text: String)]
    var splitAt: Int
    var outerIndex: Int

    let content: (Int, (desc: String, text: String)) -> Content

    var body: some View {
        VStack(alignment: .leading) {
            ForEach(Array(zip(cellListInfo.indices, cellListInfo)), id: \.0) { (innerIndex, set) in

                if innerIndex >= outerIndex && innerIndex < outerIndex+splitAt {
                    self.content(innerIndex, set)
                }
            }
        }
    }

    /// Adds the array and parameters.
    /// - Parameters:
    ///   - cellListInfo: The array of sets of information to be shown.
    ///   - splitAt: The number that the columns are to be divided.
    ///   - outerIndex: The index number of the for loop in *DetailInfoColumn*.
    ///   - content: The view to add inside of this view
    init(
        cellListInfo: [(desc: String, text: String)],
        splitAt: Int,
        outerIndex: Int,
        @ViewBuilder content: @escaping (Int, (desc: String, text: String)) -> Content
    ) {
        self.cellListInfo = cellListInfo
        self.splitAt = splitAt
        self.outerIndex = outerIndex

        self.content = content
    }
}

/// The full information label design combined.
struct DetailsCellInfo: View {

    @State var description: String
    @State var text: String
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        HStack {
            Text(LocalizedStringKey(description))
                .fontWeight(.bold)
            InfoEnclosure {
                Text(LocalizedStringKey(text))
            }
        }
        .padding(3)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8).stroke(colorScheme == .light ? Color.gray : Color.white, lineWidth: 1.2)
        )
    }
}

/// The design of the information labels in stamp cells.
struct InfoEnclosure<Content: View>: View {
    @Environment(\.colorScheme) var colorScheme

    var fontSize: CGFloat = 12.0

    let content: () -> Content

    var body: some View {
        ZStack {
            self.content()
                .font(.system(size: fontSize, weight: .regular))
                .foregroundColor(.background)
                .padding(5)
                .background(colorScheme == .light ? Color.gray : Color.white)
                .cornerRadius(5)
        }
    }

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
}
