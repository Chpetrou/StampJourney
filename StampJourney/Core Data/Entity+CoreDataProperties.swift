//
//  Entity+CoreDataProperties.swift
//  StampJourney
//
//  Created by Chris Petrou on 13/5/21.
//
//

import Foundation
import CoreData

extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var countryID: Int64
    @NSManaged public var countryPlace: String?
    @NSManaged public var date: String?
    @NSManaged public var id: Int64
    @NSManaged public var isDeprecated: Bool
    @NSManaged public var regimeSubauthority: String?
    @NSManaged public var scott: String?
    @NSManaged public var comments: NSSet?
    @NSManaged public var country: Country?
    @NSManaged public var seeAlso: NSSet?
    @NSManaged public var sourceInfo: NSSet?
    @NSManaged public var stampGroups: NSSet?

    var wrappedCountryPlace: String {
        countryPlace ?? "Not Available"
    }
    var wrappedDate: String {
        date ?? "Not Available"
    }
    var wrappedRegimeSubauthority: String {
        regimeSubauthority ?? "Not Available"
    }
    var wrappedScott: String {
        scott ?? "Not Available"
    }
    var ownedEntityList: [OwnedEntity]? { // The accessor of the feedbackList property.
        return value(forKey: "ownedEntityList") as? [OwnedEntity]
    }

    var ownedEntity: OwnedEntity? { // The accessor of the feedbackList property.
        guard let fetchedEntity = value(forKey: "ownedEntityList") as? [OwnedEntity]
        else { return nil }

        guard let entity = fetchedEntity.first else {
            return nil
        }

        return entity
    }
}

// MARK: Generated accessors for comments
extension Entity {

    @objc(addCommentsObject:)
    @NSManaged public func addToComments(_ value: EntityComment)

    @objc(removeCommentsObject:)
    @NSManaged public func removeFromComments(_ value: EntityComment)

    @objc(addComments:)
    @NSManaged public func addToComments(_ values: NSSet)

    @objc(removeComments:)
    @NSManaged public func removeFromComments(_ values: NSSet)

}

// MARK: Generated accessors for seeAlso
extension Entity {

    @objc(addSeeAlsoObject:)
    @NSManaged public func addToSeeAlso(_ value: EntitySeeAlso)

    @objc(removeSeeAlsoObject:)
    @NSManaged public func removeFromSeeAlso(_ value: EntitySeeAlso)

    @objc(addSeeAlso:)
    @NSManaged public func addToSeeAlso(_ values: NSSet)

    @objc(removeSeeAlso:)
    @NSManaged public func removeFromSeeAlso(_ values: NSSet)

}

// MARK: Generated accessors for sourceInfo
extension Entity {

    @objc(addSourceInfoObject:)
    @NSManaged public func addToSourceInfo(_ value: EntitySourceInfo)

    @objc(removeSourceInfoObject:)
    @NSManaged public func removeFromSourceInfo(_ value: EntitySourceInfo)

    @objc(addSourceInfo:)
    @NSManaged public func addToSourceInfo(_ values: NSSet)

    @objc(removeSourceInfo:)
    @NSManaged public func removeFromSourceInfo(_ values: NSSet)

}

// MARK: Generated accessors for stampGroups
extension Entity {

    @objc(addStampGroupsObject:)
    @NSManaged public func addToStampGroups(_ value: StampGroup)

    @objc(removeStampGroupsObject:)
    @NSManaged public func removeFromStampGroups(_ value: StampGroup)

    @objc(addStampGroups:)
    @NSManaged public func addToStampGroups(_ values: NSSet)

    @objc(removeStampGroups:)
    @NSManaged public func removeFromStampGroups(_ values: NSSet)

}

extension Entity: Identifiable {

}
