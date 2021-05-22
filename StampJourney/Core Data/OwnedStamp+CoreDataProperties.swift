//
//  OwnedStamp+CoreDataProperties.swift
//  StampJourney
//
//  Created by Chris Petrou on 13/5/21.
//
//

import Foundation
import CoreData

extension OwnedStamp {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OwnedStamp> {
        return NSFetchRequest<OwnedStamp>(entityName: "OwnedStamp")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var stampId: Int64
    @NSManaged public var quantity: Int16
    @NSManaged public var ownedStampGroup: OwnedStampGroup?
}

extension OwnedStamp: Identifiable {

}
