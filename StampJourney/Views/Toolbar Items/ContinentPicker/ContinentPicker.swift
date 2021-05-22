//
//  ContinentPicker.swift
//  StampJourney
//
//  Created by Chris Petrou on 13/5/21.
//

import SwiftUI

/// A picker view with all of the continents.
struct ContinentPicker: View {

    @Binding var selectedContinent: Continent?
    @Binding var selectedCountry: Country?

    var body: some View {
        Menu {
            OrderedContinentPicker(sortKey: "id", ascending: true) { (continent: Continent) in
                Button(LocalizedStringKey(continent.wrappedName)) {
                    selectedContinent = continent
                    selectedCountry = nil

                    UserDefaults.standard.set(continent.id, forKey: "Continent")
                }
            }
        } label: {
            Text(LocalizedStringKey(getContinentText(defaultText: "SelectContinent")),
                 comment: "Menu Label for the selected continent")
        }
    }

    /// The continent name or the default value.
    /// - Parameter defaultText: The default text to return in case of failure.
    /// - Returns: The continent name.
    func getContinentText(defaultText: String) -> String {
        return selectedContinent?.wrappedName ?? defaultText
    }
}
