//
//  Country+CoreDataProperties.swift
//  StampJourney
//
//  Created by Chris Petrou on 13/5/21.
//
//

import Foundation
import CoreData

extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

    @NSManaged public var code31661Alpha2: String?
    @NSManaged public var code31661Alpha3: String?
    @NSManaged public var code31661Num: Int64
    @NSManaged public var codeIana: String?
    @NSManaged public var codeTir: String?
    @NSManaged public var continentID: Int64
    @NSManaged public var id: Int64
    @NSManaged public var isDeprecated: Bool
    @NSManaged public var name: String?
    @NSManaged public var officialName: String?
    @NSManaged public var parentID: Int64
    @NSManaged public var predecessorID: Int64
    @NSManaged public var successorID: Int64
    @NSManaged public var child: Country?
    @NSManaged public var continent: Continent?
    @NSManaged public var parent: Country?
    @NSManaged public var predecessor: Country?
    @NSManaged public var stampEntities: NSSet?
    @NSManaged public var successor: Country?

    var wrappedCode31661Alpha2: String {
        code31661Alpha2 ?? "Not Available"
    }
    var wrappedCode31661Alpha3: String {
        code31661Alpha3 ?? "Not Available"
    }
    var wrappedCodeIana: String {
        codeIana ?? "Not Available"
    }
    var wrappedCodeTir: String {
        codeTir ?? "Not Available"
    }
    var wrappedName: String {
        name ?? "Not Available"
    }
    var wrappedOfficialName: String {
        officialName ?? "Not Available"
    }
    var totalStampsCounter: Int {
        guard let entities = stampEntities?.allObjects as? [Entity] else { return 0 }

        var total = 0
        for entity in entities {
            let optionals = entity.ownedEntity
            total += Int(optionals?.ownedStampsCounter ?? 0)
        }
        return total
    }
    var toBeShown: Bool {
        return totalStampsCounter > 0
    }
}

// MARK: Generated accessors for stampEntities
extension Country {

    @objc(addStampEntitiesObject:)
    @NSManaged public func addToStampEntities(_ value: Entity)

    @objc(removeStampEntitiesObject:)
    @NSManaged public func removeFromStampEntities(_ value: Entity)

    @objc(addStampEntities:)
    @NSManaged public func addToStampEntities(_ values: NSSet)

    @objc(removeStampEntities:)
    @NSManaged public func removeFromStampEntities(_ values: NSSet)

}

extension Country: Identifiable {

}
