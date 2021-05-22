//
//  StampDetailView.swift
//  StampJourney
//
//  Created by Chris Petrou on 13/5/21.
//

import SwiftUI

/// A list of stamp cells.
struct StampDetailView: View {

    @Binding var stampGroup: StampGroup
    @Binding var refresh: Bool

    /// All fetched stamps ordered by id.
    var allStampsOrderedById: [Stamp] {
        return (stampGroup.stamps?.allObjects as? [Stamp])?.sorted(by: { $0.id < $1.id }) ?? []
    }

    var body: some View {
        List(allStampsOrderedById, id: \.self) { stamp in
            StampDetailViewCell(stamp: stamp, stampGroup: stampGroup, isOwned: stamp.isOwned, refresh: $refresh)
        }
        .frame(minWidth: 900)
    }
}
