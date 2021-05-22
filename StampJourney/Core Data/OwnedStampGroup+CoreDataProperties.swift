//
//  OwnedStampGroup+CoreDataProperties.swift
//  StampJourney
//
//  Created by Chris Petrou on 13/5/21.
//
//

import Foundation
import CoreData

extension OwnedStampGroup {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OwnedStampGroup> {
        return NSFetchRequest<OwnedStampGroup>(entityName: "OwnedStampGroup")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var ownedStampsCounter: Int16
    @NSManaged public var stampGroupId: Int64
    @NSManaged public var ownedStamps: NSSet?
    @NSManaged public var ownedEntity: OwnedEntity?

    var totalStampsCount: Int { // The accessor of the feedbackList property.
        guard let fetchedStampGroup = value(forKey: "stampGroupList") as? [StampGroup]
        else { return 0 }

        return (fetchedStampGroup.first?.stamps?.count) ?? 0
    }

    var stampGroup: StampGroup? { // The accessor of the feedbackList property.
        guard let fetchedStampGroup = value(forKey: "stampGroupList") as? [StampGroup]
        else { return nil }

        return fetchedStampGroup.first
    }

    var isOwned: Troolean {
        if ownedStampsCounter == totalStampsCount {
            return .true
        } else if ownedStampsCounter > 0 && ownedStampsCounter < totalStampsCount {
            return .partially
        } else {
            return .false
        }
    }
}

// MARK: Generated accessors for ownedStamps
extension OwnedStampGroup {

    @objc(addOwnedStampsObject:)
    @NSManaged public func addToOwnedStamps(_ value: OwnedStamp)

    @objc(removeOwnedStampsObject:)
    @NSManaged public func removeFromOwnedStamps(_ value: OwnedStamp)

    @objc(addOwnedStamps:)
    @NSManaged public func addToOwnedStamps(_ values: NSSet)

    @objc(removeOwnedStamps:)
    @NSManaged public func removeFromOwnedStamps(_ values: NSSet)

}

extension OwnedStampGroup: Identifiable {

}
