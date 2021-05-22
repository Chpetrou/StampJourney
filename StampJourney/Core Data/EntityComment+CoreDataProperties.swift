//
//  EntityComment+CoreDataProperties.swift
//  StampJourney
//
//  Created by Chris Petrou on 13/5/21.
//
//

import Foundation
import CoreData

extension EntityComment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EntityComment> {
        return NSFetchRequest<EntityComment>(entityName: "EntityComment")
    }

    @NSManaged public var comment: String?
    @NSManaged public var id: Int64
    @NSManaged public var stampEntityID: Int64
    @NSManaged public var stampEntity: Entity?

    var wrappedComment: String {
        comment ?? "Not Available"
    }
}

extension EntityComment: Identifiable {

}
