//
//  GeneralViewModel.swift
//  StampJourney
//
//  Created by Chris Petrou on 13/5/21.
//

import SwiftUI

/// A wrapper view model containing other view models.
///
/// Used as a workaround for environment object, as it can't have two objects with the same type.
class GroupViewModel: ObservableObject {
    @Published var libraryViewModel: BaseViewModel!
    @Published var filterViewModel: BaseViewModel!

    /// Initialises contained view models.
    /// - Parameter viewContext: The managed object context used for interacting with the database.
    init(viewContext: NSManagedObjectContext) {
        libraryViewModel = BaseViewModel(viewContext: viewContext, isLibrary: true)
        filterViewModel = BaseViewModel(viewContext: viewContext, isLibrary: false)
    }
}
