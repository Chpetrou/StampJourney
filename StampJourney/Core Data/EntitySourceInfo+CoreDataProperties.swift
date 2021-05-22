//
//  EntitySourceInfo+CoreDataProperties.swift
//  StampJourney
//
//  Created by Chris Petrou on 13/5/21.
//
//

import Foundation
import CoreData

extension EntitySourceInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EntitySourceInfo> {
        return NSFetchRequest<EntitySourceInfo>(entityName: "EntitySourceInfo")
    }

    @NSManaged public var id: Int64
    @NSManaged public var sourceInfo: String?
    @NSManaged public var stampEntityID: Int64
    @NSManaged public var stampEntity: Entity?

    var wrappedSourceInfo: String {
        sourceInfo ?? "Not Available"
    }
}

extension EntitySourceInfo: Identifiable {

}
