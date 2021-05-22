//
//  OwnedEntity+CoreDataProperties.swift
//  StampJourney
//
//  Created by Chris Petrou on 13/5/21.
//
//

import Foundation
import CoreData

extension OwnedEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OwnedEntity> {
        return NSFetchRequest<OwnedEntity>(entityName: "OwnedEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var entityId: Int64
    @NSManaged public var ownedStampsCounter: Int16
    @NSManaged public var ownedStampGroups: NSSet?

}

// MARK: Generated accessors for ownedStampGroups
extension OwnedEntity {

    @objc(addOwnedStampGroupsObject:)
    @NSManaged public func addToOwnedStampGroups(_ value: OwnedStampGroup)

    @objc(removeOwnedStampGroupsObject:)
    @NSManaged public func removeFromOwnedStampGroups(_ value: OwnedStampGroup)

    @objc(addOwnedStampGroups:)
    @NSManaged public func addToOwnedStampGroups(_ values: NSSet)

    @objc(removeOwnedStampGroups:)
    @NSManaged public func removeFromOwnedStampGroups(_ values: NSSet)

}

extension OwnedEntity: Identifiable {

}
