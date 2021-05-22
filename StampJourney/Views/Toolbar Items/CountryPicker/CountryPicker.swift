//
//  CountryPicker.swift
//  StampJourney
//
//  Created by Chris Petrou on 13/5/21.
//

import SwiftUI

/// A picker view with all of the countries per continent.
struct CountryPicker: View {

    @Binding var selectedContinent: Continent?
    @Binding var selectedCountry: Country?
    @Binding var isLibrary: Bool

    /// All fetched countries ordered by id.
    var allCountriesOrderedById: [Country] {
        return (selectedContinent?.countries?.allObjects as? [Country])?.sorted(by: { $0.id < $1.id }) ?? []
    }

    var body: some View {
        if selectedContinent != nil {
            Menu {
                Group {
                    Menu {
                        ForEach(allCountriesOrderedById, id: \.self) { (country: Country) in
                            if (!isLibrary || country.toBeShown) && !country.isDeprecated {
                                Button(action: {
                                    selectedCountry = country

                                    if isLibrary && country.toBeShown {
                                        UserDefaults.standard.set(country.id, forKey: "LibraryCountry")
                                    } else {
                                        UserDefaults.standard.set(country.id, forKey: "CatalogueCountry")
                                    }
                                }) {
                                    MenuCountryView(country: country)
                                }
                            }
                        }
                    } label: {
                        Text("CurrentCountries", comment: "Menu label for the countries currently in existence")
                    }
                    Menu {
                        ForEach(allCountriesOrderedById, id: \.self) { (country: Country) in
                            if (!isLibrary || country.toBeShown) && country.isDeprecated {
                                Button(action: {
                                    selectedCountry = country

                                    if isLibrary && country.toBeShown {
                                        UserDefaults.standard.set(country.id, forKey: "LibraryCountry")
                                    } else {
                                        UserDefaults.standard.set(country.id, forKey: "CatalogueCountry")
                                    }
                                }) {
                                    MenuCountryView(country: country)
                                }
                            }
                        }
                    } label: {
                        Text("FormerCountries", comment: "Menu label for the former countries")
                    }
                }
            } label: {
                Text(LocalizedStringKey(getCountryText(defaultText: "Choose Country")),
                     comment: "Menu Label for the selected country")
            }
        }
    }

    /// The continent name or the default value.
    /// - Parameter defaultText: The default text to return in case of failure.
    /// - Returns: The continent name.
    func getCountryText(defaultText: String) -> String {
        return selectedCountry?.wrappedName ?? defaultText
    }
}
