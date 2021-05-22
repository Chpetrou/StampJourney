//
//  StampGroup+CoreDataProperties.swift
//  StampJourney
//
//  Created by Chris Petrou on 13/5/21.
//
//

import Foundation
import CoreData

extension StampGroup {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StampGroup> {
        return NSFetchRequest<StampGroup>(entityName: "StampGroup")
    }

    @NSManaged public var design: String?
    @NSManaged public var engraving: String?
    @NSManaged public var fromDateIssued: Int64
    @NSManaged public var generalDate: String?
    @NSManaged public var groupNo: String?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var perforation: String?
    @NSManaged public var sheetsize: String?
    @NSManaged public var stampEntityID: Int64
    @NSManaged public var toDateIssued: Int64
    @NSManaged public var type: String?
    @NSManaged public var watermarkPath: URL?
    @NSManaged public var watermarkUrl: URL?
    @NSManaged public var wm: String?
    @NSManaged public var stampEntity: Entity?
    @NSManaged public var stampGroupImages: NSSet?
    @NSManaged public var stamps: NSSet?

    var wrappedDesign: String {
        design ?? "Not Available"
    }
    var wrappedEngraving: String {
        engraving ?? "Not Available"
    }
    var wrappedGeneralDate: String {
        generalDate ?? "Not Available"
    }
    var wrappedGroupNo: String {
        groupNo ?? "Not Available"
    }
    var wrappedName: String {
        name ?? "Not Available"
    }
    var wrappedPerforation: String {
        perforation ?? "Not Available"
    }
    var wrappedSheetsize: String {
        sheetsize ?? "Not Available"
    }
    var wrappedType: String {
        type ?? "Not Available"
    }
    var wrappedWm: String {
        wm ?? "Not Available"
    }
    var ownedStampGroupList: [OwnedStampGroup]? { // The accessor of the feedbackList property.
        return value(forKey: "ownedStampGroupList") as? [OwnedStampGroup]
    }

    var ownedStampGroup: OwnedStampGroup? { // The accessor of the feedbackList property.
        guard let fetchedEntity = value(forKey: "ownedStampGroupList") as? [OwnedStampGroup]
        else { return nil }

        guard let entity = fetchedEntity.first else {
            return nil
        }

        return entity
    }

    var totalStamps: Int {
        return stamps?.count ?? 0
    }

    var isOwned: Troolean {
        guard let ownedStampGroups = ownedStampGroupList else {
            return .false
        }

        if ownedStampGroups.count == 0 {
            return .false
        }

        return ownedStampGroups[0].isOwned
    }
}

// MARK: Generated accessors for stampGroupImages
extension StampGroup {

    @objc(addStampGroupImagesObject:)
    @NSManaged public func addToStampGroupImages(_ value: StampGroupImage)

    @objc(removeStampGroupImagesObject:)
    @NSManaged public func removeFromStampGroupImages(_ value: StampGroupImage)

    @objc(addStampGroupImages:)
    @NSManaged public func addToStampGroupImages(_ values: NSSet)

    @objc(removeStampGroupImages:)
    @NSManaged public func removeFromStampGroupImages(_ values: NSSet)

}

// MARK: Generated accessors for stamps
extension StampGroup {

    @objc(addStampsObject:)
    @NSManaged public func addToStamps(_ value: Stamp)

    @objc(removeStampsObject:)
    @NSManaged public func removeFromStamps(_ value: Stamp)

    @objc(addStamps:)
    @NSManaged public func addToStamps(_ values: NSSet)

    @objc(removeStamps:)
    @NSManaged public func removeFromStamps(_ values: NSSet)

}

extension StampGroup: Identifiable {

}
