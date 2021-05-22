//
//  SettingsViewModel.swift
//  StampJourney
//
//  Created by Chris Petrou on 13/5/21.
//

import SwiftUI

/// The view model for the settings view.
class SettingsViewModel: ObservableObject {

    /// The preferred colour scheme for the app.
    @Published var prefColorScheme: ExtendedColorScheme = .auto {
        willSet {
            UserDefaults.standard.set(newValue.name, forKey: "PrefColorScheme")
        }
    }

    /// Initializes the values for the view model.
    init() {
        let preferredColorScheme: String? = UserDefaults.standard.string(forKey: "PrefColorScheme")

        guard let colorScheme = preferredColorScheme else { return }

        switch colorScheme {
        case ExtendedColorScheme.light.name:
            prefColorScheme = .light
        case ExtendedColorScheme.dark.name:
            prefColorScheme = .dark
        default:
            prefColorScheme = .auto
        }
    }
}
