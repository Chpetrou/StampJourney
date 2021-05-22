//
//  MenuCountryView.swift
//  StampJourney
//
//  Created by Chris Petrou on 13/5/21.
//

import SwiftUI

/// The combined string to show on the country picker view.
struct MenuCountryView: View {
    @State var country: Country

    var body: some View {
        Text("stampCount \(country.totalStampsCounter)") +
            Text(LocalizedStringKey(country.wrappedName), comment: "The common name for the country") +
            Text(" (")
            .font(.caption) +
            Text(LocalizedStringKey(country.wrappedOfficialName), comment: "The official name of the country")
            .font(.caption) +
            Text(")")
            .font(.caption)
    }
}
