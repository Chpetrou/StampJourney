//
//  StampDetailViewCell.swift
//  StampJourney
//
//  Created by Chris Petrou on 13/5/21.
//

import SwiftUI

extension StampDetailViewCell {
    var body: some View {
        ZStack(alignment: .leading) {
            Color.background
            HStack {
                VStack {
                    if let stampImage = stamp.imageUrl?.absoluteString {
                        RemotelyLoadedImageView(url: stampImage)
                        if refresh {
                        LibraryConnectionButtonView(
                            stampObject: $stamp,
                            stampGroup: $stampGroup,
                            entity: $stampGroup.stampEntity,
                            isOwned: $isOwned,
                            refresh: $refresh
                        )
                        } else {
                            LibraryConnectionButtonView(
                                stampObject: $stamp,
                                stampGroup: $stampGroup,
                                entity: $stampGroup.stampEntity,
                                isOwned: $isOwned,
                                refresh: $refresh
                            )
                        }
                    }
                }
                DetailsCellTable(cellListInfo: list, splitAt: 4)
            }
            .padding(15)
        }
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}
