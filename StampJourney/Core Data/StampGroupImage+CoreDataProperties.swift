//
//  StampGroupImage+CoreDataProperties.swift
//  StampJourney
//
//  Created by Chris Petrou on 13/5/21.
//
//

import Foundation
import CoreData

extension StampGroupImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StampGroupImage> {
        return NSFetchRequest<StampGroupImage>(entityName: "StampGroupImage")
    }

    @NSManaged public var id: Int64
    @NSManaged public var imagePath: URL?
    @NSManaged public var imageUrl: URL?
    @NSManaged public var stampGroupID: Int64
    @NSManaged public var stampGroup: StampGroup?

}

extension StampGroupImage: Identifiable {

}
