//
//  StampDetailViewCellDef.swift
//  StampJourney
//
//  Created by Chris Petrou on 13/5/21.
//

import SwiftUI

/// The cell of a stamp view.
struct StampDetailViewCell: View {
    @State var stamp: Stamp
    @State var stampGroup: StampGroup
    @State var isOwned: Bool = false
    @Binding var refresh: Bool
    @Environment(\.colorScheme) var colorScheme
    /// An array of sets to input to *DetailsCellTable* to build the view.
    var list: [(desc: String, text: String)] {
        [
            (desc: "descriptionText: ", text: stamp.wrappedDescriptionText),
            (desc: "denominationValue: ", text: stamp.wrappedDenominationValue),
            (desc: "stampUsed: ", text: stamp.wrappedStampUsed),
            (desc: "design: ", text: stamp.wrappedDesign),

            (desc: "color: ", text: stamp.wrappedColor),
            (desc: "denominationCurrency: ", text: stamp.wrappedDenominationCurrency),
            (desc: "stampUnused: ", text: stamp.wrappedStampUnused),
            (desc: "engraving: ", text: stamp.wrappedEngraving),

            (desc: "stampType: ", text: stamp.wrappedStampType),
            (desc: "theme: ", text: stamp.wrappedTheme),
            (desc: "mintCondition: ", text: stamp.wrappedMintCondition),
            (desc: "perforations: ", text: stamp.wrappedPerforations),

            (desc: "dateOfIssue: ", text: stamp.wrappedDateOfIssue),
            (desc: "sheetSize: ", text: stamp.wrappedSheetSize),
            (desc: "letterFdc: ", text: stamp.wrappedLetterFdc),
            (desc: "heightWidth: ", text: stamp.wrappedHeightWidth),

            (desc: "stampsIssued: ", text: stamp.wrappedStampsIssued),
            (desc: "stampNo: ", text: stamp.wrappedStampNo),
            (desc: "currency: ", text: stamp.wrappedCurrency)
        ]
    }
}
