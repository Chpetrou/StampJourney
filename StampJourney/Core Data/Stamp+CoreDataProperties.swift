//
//  Stamp+CoreDataProperties.swift
//  StampJourney
//
//  Created by Chris Petrou on 13/5/21.
//
//

import Foundation
import CoreData

extension Stamp {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stamp> {
        return NSFetchRequest<Stamp>(entityName: "Stamp")
    }

    @NSManaged public var color: String?
    @NSManaged public var currency: String?
    @NSManaged public var dateOfIssue: String?
    @NSManaged public var denominationCurrency: String?
    @NSManaged public var denominationValue: String?
    @NSManaged public var descriptionText: String?
    @NSManaged public var design: String?
    @NSManaged public var engraving: String?
    @NSManaged public var heightWidth: String?
    @NSManaged public var id: Int64
    @NSManaged public var imagePath: URL?
    @NSManaged public var imageUrl: URL?
    @NSManaged public var letterFdc: String?
    @NSManaged public var mintCondition: String?
    @NSManaged public var perforations: String?
    @NSManaged public var sheetSize: String?
    @NSManaged public var stampGroupID: Int64
    @NSManaged public var stampNo: String?
    @NSManaged public var stampsIssued: String?
    @NSManaged public var stampType: String?
    @NSManaged public var stampUnused: String?
    @NSManaged public var stampUsed: String?
    @NSManaged public var theme: String?
    @NSManaged public var stampGroup: StampGroup?

    var wrappedColor: String {
        guard let wrappedValue = color else { return "Not Available" }

        if wrappedValue.isEmpty {
            return "Not Available"
        }

        return wrappedValue
    }
    var wrappedCurrency: String {
        guard let wrappedValue = currency else { return "Not Available" }

        if wrappedValue.isEmpty {
            return "Not Available"
        }

        return wrappedValue
    }
    var wrappedDateOfIssue: String {
        guard let wrappedValue = dateOfIssue else { return "Not Available" }

        if wrappedValue.isEmpty {
            return "Not Available"
        }

        return wrappedValue
    }
    var wrappedDenominationCurrency: String {
        guard let wrappedValue = denominationCurrency else { return "Not Available" }

        if wrappedValue.isEmpty {
            return "Not Available"
        }

        return wrappedValue
    }
    var wrappedDenominationValue: String {
        guard let wrappedValue = denominationValue else { return "Not Available" }

        if wrappedValue.isEmpty {
            return "Not Available"
        }

        return wrappedValue
    }
    var wrappedDescriptionText: String {
        guard let wrappedValue = descriptionText else { return "Not Available" }

        if wrappedValue.isEmpty {
            return "Not Available"
        }

        return wrappedValue
    }
    var wrappedDesign: String {
        guard let wrappedValue = design else { return "Not Available" }

        if wrappedValue.isEmpty {
            return "Not Available"
        }

        return wrappedValue
    }
    var wrappedEngraving: String {
        guard let wrappedValue = engraving else { return "Not Available" }

        if wrappedValue.isEmpty {
            return "Not Available"
        }

        return wrappedValue
    }
    var wrappedHeightWidth: String {
        guard let wrappedValue = heightWidth else { return "Not Available" }

        if wrappedValue.isEmpty {
            return "Not Available"
        }

        return wrappedValue
    }
    var wrappedLetterFdc: String {
        guard let wrappedValue = letterFdc else { return "Not Available" }

        if wrappedValue.isEmpty {
            return "Not Available"
        }

        return wrappedValue
    }
    var wrappedMintCondition: String {
        guard let wrappedValue = mintCondition else { return "Not Available" }

        if wrappedValue.isEmpty {
            return "Not Available"
        }

        return wrappedValue
    }
    var wrappedPerforations: String {
        guard let wrappedValue = perforations else { return "Not Available" }

        if wrappedValue.isEmpty {
            return "Not Available"
        }

        return wrappedValue
    }
    var wrappedSheetSize: String {
        guard let wrappedValue = sheetSize else { return "Not Available" }

        if wrappedValue.isEmpty {
            return "Not Available"
        }

        return wrappedValue
    }
    var wrappedStampNo: String {
        guard let wrappedValue = stampNo else { return "Not Available" }

        if wrappedValue.isEmpty {
            return "Not Available"
        }

        return wrappedValue
    }
    var wrappedStampsIssued: String {
        guard let wrappedValue = stampsIssued else { return "Not Available" }

        if wrappedValue.isEmpty {
            return "Not Available"
        }

        return wrappedValue
    }
    var wrappedStampType: String {
        guard let wrappedValue = stampType else { return "Not Available" }

        if wrappedValue.isEmpty {
            return "Not Available"
        }

        return wrappedValue
    }
    var wrappedStampUnused: String {
        guard let wrappedValue = stampUnused else { return "Not Available" }

        if wrappedValue.isEmpty {
            return "Not Available"
        }

        return wrappedValue
    }
    var wrappedStampUsed: String {
        guard let wrappedValue = stampUsed else { return "Not Available" }

        if wrappedValue.isEmpty {
            return "Not Available"
        }

        return wrappedValue
    }
    var wrappedTheme: String {
        guard let wrappedValue = theme else { return "Not Available" }

        if wrappedValue.isEmpty {
            return "Not Available"
        }

        return wrappedValue
    }
    var ownedStampList: [OwnedStamp]? { // The accessor of the feedbackList property.
        return value(forKey: "ownedStampList") as? [OwnedStamp]
    }

    var isOwned: Bool {
        guard let ownedStamps = ownedStampList else {
            return false
        }

        if ownedStamps.count != 0 {
            return true
        }

        return false
    }
}

extension Stamp: Identifiable {

}
