//
//  Continent+CoreDataProperties.swift
//  StampJourney
//
//  Created by Chris Petrou on 13/5/21.
//
//

import Foundation
import CoreData

extension Continent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Continent> {
        return NSFetchRequest<Continent>(entityName: "Continent")
    }

    @NSManaged public var id: Int64
    @NSManaged public var isDeprecated: Bool
    @NSManaged public var name: String?
    @NSManaged public var countries: NSSet?

    var wrappedName: String {
        name ?? "Not Available"
    }
}

// MARK: Generated accessors for countries
extension Continent {

    @objc(addCountriesObject:)
    @NSManaged public func addToCountries(_ value: Country)

    @objc(removeCountriesObject:)
    @NSManaged public func removeFromCountries(_ value: Country)

    @objc(addCountries:)
    @NSManaged public func addToCountries(_ values: NSSet)

    @objc(removeCountries:)
    @NSManaged public func removeFromCountries(_ values: NSSet)

}

extension Continent: Identifiable {

}
