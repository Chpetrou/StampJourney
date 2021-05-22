//
//  EntitySeeAlso+CoreDataProperties.swift
//  StampJourney
//
//  Created by Chris Petrou on 13/5/21.
//
//

import Foundation
import CoreData

extension EntitySeeAlso {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EntitySeeAlso> {
        return NSFetchRequest<EntitySeeAlso>(entityName: "EntitySeeAlso")
    }

    @NSManaged public var id: Int64
    @NSManaged public var seeAlso: String?
    @NSManaged public var stampEntityID: Int64
    @NSManaged public var stampEntity: Entity?

    var wrappedSeeAlso: String {
        seeAlso ?? "Not Available"
    }
}

extension EntitySeeAlso: Identifiable {

}
