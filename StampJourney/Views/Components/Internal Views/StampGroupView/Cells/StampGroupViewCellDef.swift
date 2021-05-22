//
//  StampGroupViewCellDef.swift
//  StampJourney
//
//  Created by Chris Petrou on 13/5/21.
//

import SwiftUI

/// The cell of a stamp group view.
struct StampGroupViewCell: View, Hashable {
    @State var stampGroup: StampGroup
    @State var activeRow: Bool = false
    @State var isOwned: Troolean = .false
    @Binding var refresh: Bool
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var groupViewModel: GroupViewModel

    static func == (lhs: StampGroupViewCell, rhs: StampGroupViewCell) -> Bool {
        return lhs.stampGroup.id == rhs.stampGroup.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.stampGroup.id)
    }

    /// The country of a stamp group object.
    var stampGroupCountry: String {
        return stampGroup.stampEntity?.country?.wrappedName ?? "Not Available"
    }
}
