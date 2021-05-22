//
//  BaseViewModel.swift
//  StampJourney
//
//  Created by Chris Petrou on 13/5/21.
//

import SwiftUI

/// The base view model for the stamp lists.
class BaseViewModel: ObservableObject {
    /// The view context to interact with Core Data.
    var viewContext: NSManagedObjectContext

    /// The initialization of parameters.
    /// - Parameter viewContext: The view context to interact with Core Data.
    init(viewContext: NSManagedObjectContext, isLibrary: Bool = false) {
        self.viewContext = viewContext
        let continent: Int? = UserDefaults.standard.integer(forKey: "Continent")
        let country: Int? = getCountryIdByView(isLibrary: isLibrary)
        guard let continentId = continent else { return }
        guard let countryId = country else { return }

        if continentId != 0 {
            selectedContinent = getContinent(with: continentId)
        }
        if countryId != 0 {
            selectedCountry = getCountry(with: countryId)
        }
    }

    /// The minimum date available for stamp filtering.
    var minDate: Int = 1840
    /// The maximum date available for stamp filtering.
    var maxDate: Int = Calendar.current.component(.year, from: Date())

    /// The from date filter that is selected from the picker.
    @Published var fromDate: Int = 0
    /// The to date filter that is selected from the picker.
    @Published var toDate: Int = 0
    /// The continent selected from the continent picker.
    @Published var selectedContinent: Continent?
    /// The country selected from the country picker.
    @Published var selectedCountry: Country?
    /// The text searched in the search view component.
    @Published var searchText: String = ""

    /// Returns the country id for the selected country or returns 0.
    var selectedCountryId: Int {
        Int(selectedCountry?.id ?? 0)
    }

    /// The values to show on the *from date* picker.
    var fromDataRange: ClosedRange<Int> {
        if toDate == 0 {
            return minDate...maxDate
        }
        return minDate...toDate
    }

    /// The values to show on the *to date* picker.
    var toDataRange: ClosedRange<Int> {
        if fromDate == 0 {
            return minDate...maxDate
        }
        return fromDate...maxDate
    }

    /// A toggle that enables the filtering by year.
    @Published var dateFilterToggle: Bool = false

    /// Creates an array of filters to use with the filtering lists.
    var parametersArray: [FilterParameter] {
        var tempArray: [FilterParameter] = []

        tempArray.append(
            FilterParameter(key: "stampEntity.country.id", comparison: .equal, value: String(selectedCountryId))
        )

        if fromDate != 0 && dateFilterToggle {
            tempArray.append(
                FilterParameter(key: "fromDateIssued", comparison: .greaterThanOrEqual, value: String(fromDate))
            )
        }
        if toDate != 0  && dateFilterToggle {
            tempArray.append(
                FilterParameter(key: "toDateIssued", comparison: .lessThanOrEqual, value: String(toDate))
            )
        }

        if !searchText.isEmpty && searchText.count > 2 {
            tempArray.append(FilterParameter(key: "name", comparison: .contains, value: self.searchText))
        }

        return tempArray
    }

    /// The country object with specified id.
    /// - Parameter id: The id of the requested country.
    /// - Returns: The country object with the specified id.
    func getCountry(with id: Int) -> Country? {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Country")
        fetchRequest.predicate = NSPredicate(format: "%K == %@", "id", String(id))
        fetchRequest.fetchLimit = 1

        do {
            let countryArray = try viewContext.fetch(fetchRequest) as? [Country]

            guard let unwrappedCountryArray = countryArray
            else { return nil }

            let country = unwrappedCountryArray.first

            return country

        } catch {}

        return nil
    }

    /// The continent object with specified id.
    /// - Parameter id: The id of the requested continent.
    /// - Returns: The continent object with the specified id.
    func getContinent(with id: Int) -> Continent? {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Continent")
        fetchRequest.predicate = NSPredicate(format: "%K == %@", "id", String(id))
        fetchRequest.fetchLimit = 1

        do {
            let continentArray = try viewContext.fetch(fetchRequest) as? [Continent]

            guard let unwrappedContinentArray = continentArray
            else { return nil }

            let continent = unwrappedContinentArray.first

            return continent

        } catch {}

        return nil
    }

    /// Get the user defaults country id value depending on the view.
    /// - Parameter isLibrary: Boolean denoting the view
    /// - Returns: An optional country id.
    func getCountryIdByView(isLibrary: Bool) -> Int? {
        if isLibrary {
            return UserDefaults.standard.integer(forKey: "LibraryCountry")
        }
        return UserDefaults.standard.integer(forKey: "CatalogueCountry")
    }
}
