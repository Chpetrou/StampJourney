//
//  LibraryConnectionButtonExtension.swift
//  StampJourney
//
//  Created by Chris Petrou on 13/5/21.
//

import SwiftUI

extension LibraryConnectionButtonView {
    /// Returns the system icon for the **LibraryConnectionButton**
    /// based on the stamp group ownership.
    var stampGroupSystemImage: String {
        switch isStampGroupOwned {
        case .true:
            return "checkmark.shield.fill"
        case .partially:
            return "shield.lefthalf.fill"
        case .false:
            return "plus.circle.fill"
        }
    }

    /// Returns the text for the **LibraryConnectionButton**
    /// based on the stamp group ownership.
    var stampGroupText: String {
        switch isStampGroupOwned {
        case .true:
            return "Owned"
        case .partially:
            return "PartiallyOwned"
        case .false:
            return "AddToLibrary"
        }
    }

    /// Returns the system icon for the **LibraryConnectionButton**
    /// based on the stamp ownership.
    var stampSystemImage: String {
        switch isStampOwned {
        case true:
            return "checkmark.shield.fill"
        case false:
            return "plus.circle.fill"
        }
    }

    /// Returns the text for the **LibraryConnectionButton**
    /// based on the stamp ownership.
    var stampText: String {
        switch isStampOwned {
        case true:
            return "Owned"
        case false:
            return "AddToLibrary"
        }
    }

    /// Returns the colour for the **LibraryConnectionButton**
    /// based on the stamp or stamp group ownership.
    var buttonColor: Color {
        switch buttonType {
        case .stamp:
            switch isStampOwned {
            case true:
                return .green
            case false:
                return .tertiaryBackground
            }
        case .stampGroup:
            switch isStampGroupOwned {
            case .true:
                return .green
            case .partially:
                return .yellow
            case .false:
                return .tertiaryBackground
            }
        }
    }
}

extension LibraryConnectionButtonView {
    /// Updates the stamp object to owned or not owned.
    ///
    /// - Parameters:
    ///   - isStampOwned: Indicates the status of the stamp ownership.
    ///   - stamp: The stamp object that the button is used for.
    ///
    ///
    ///  Checks the status of the stamp ownership and executes the function that does the reversed action.
    func updateOwnedStamp(isStampOwned: Bool, stamp: Stamp) {
        if isStampOwned {
            removeStampFromOwned()
        } else {
            addStampToOwned()
        }
    }

    /// Updates the stamp group object to owned, partially owned or not owned.
    ///
    /// - Parameters:
    ///   - isStampGroupOwned: Indicates the status of the stamp group ownership.
    ///   - stampGroup: The stamp group object that the button is used for.
    ///
    ///  Checks the status of the stamp group ownership and executes the function that does the reversed action.
    func updateOwnedStampGroup(isStampGroupOwned: Troolean, stampGroup: StampGroup) {
        if isStampGroupOwned != .false {
            removeStampGroupFromOwned()
        } else {
            addStampGroupToOwned()
        }
    }
}

extension LibraryConnectionButtonView {

    /// Adds a stamp to the owned database.
    ///
    /// Changes the stamp status to owned, by adding it to the owned database.
    /// It checks if it has a group, if not it creates one by calling *createOwnedStampGroup*
    /// otherwise, it adds it as a parent object.
    func addStampToOwned() {
        let newOwnedStamp = OwnedStamp(context: managedObjectContext)
        newOwnedStamp.id = UUID()
        newOwnedStamp.stampId = stampObjectId
        newOwnedStamp.quantity = 1

        if newOwnedStamp.ownedStampGroup == nil {
            newOwnedStamp.ownedStampGroup = createOwnedStampGroup()
            newOwnedStamp.ownedStampGroup?.ownedEntity = createOwnedEntity()
        }

        newOwnedStamp.ownedStampGroup?.ownedStampsCounter += 1
        newOwnedStamp.ownedStampGroup?.ownedEntity?.ownedStampsCounter += 1

        do {
            try managedObjectContext.save()
        } catch {
            fatalError("Failed to update tables: \(error)")
        }
        managedObjectContext.refresh(newOwnedStamp, mergeChanges: true)
    }

    /// Adds a stamp group to the owned database.
    ///
    /// Changes the stamp group status to owned, by adding it to the owned database.
    /// It creates and adds all the stamps that belong to this group as children by calling *createOwnedStamp*.
    /// Also it checks if it has an entity, if not it creates one by calling *createOwnedEntity*
    /// otherwise, it adds it as a parent object.
    func addStampGroupToOwned() {
        let newOwnedStampGroup: OwnedStampGroup
        do {
            newOwnedStampGroup = OwnedStampGroup(context: managedObjectContext)
            newOwnedStampGroup.id = UUID()
            newOwnedStampGroup.stampGroupId = stampGroupObjectId
            newOwnedStampGroup.ownedStampsCounter = 0

            if newOwnedStampGroup.ownedEntity == nil {
                newOwnedStampGroup.ownedEntity = createOwnedEntity()
            }

            guard let stampGroupStamps = stampGroupObject.stamps?.allObjects as? [Stamp]
            else { return }

            for stamp in stampGroupStamps {
                newOwnedStampGroup.addToOwnedStamps(createOwnedStamp(internalStampId: stamp.id)!)
            }

            newOwnedStampGroup.ownedStampsCounter = Int16(newOwnedStampGroup.totalStampsCount)
            newOwnedStampGroup.ownedEntity?.ownedStampsCounter += newOwnedStampGroup.ownedStampsCounter

            try managedObjectContext.save()
        } catch {
            fatalError("Failed to update tables: \(error)")
        }
        managedObjectContext.refresh(newOwnedStampGroup, mergeChanges: true)
    }
}

extension LibraryConnectionButtonView {
    /// Creates and returns a new stamp object.
    ///
    /// - Parameter internalStampId: The stamp id that the new object will be having.
    /// - Returns: The newly created stamp object.
    func createOwnedStamp(internalStampId: Int64 = 0) -> OwnedStamp? {
        let newOwnedStamp: OwnedStamp
        do {
            newOwnedStamp = OwnedStamp(context: managedObjectContext)

            newOwnedStamp.id = UUID()
            newOwnedStamp.stampId = internalStampId
            newOwnedStamp.quantity = 1

            try managedObjectContext.save()
        } catch {
            fatalError("Failed to update tables: \(error)")
        }
        managedObjectContext.refresh(newOwnedStamp, mergeChanges: true)

        return newOwnedStamp
    }

    /// Creates and returns a new stamp group object.
    ///
    /// - Returns: The newly created stamp group object.
    ///
    /// Checks if the stamp group object already exists and returns it. If it does not exist, it creates a new stamp group object and returns it.
    func createOwnedStampGroup() -> OwnedStampGroup? {
        let stampGroupsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "OwnedStampGroup")
        stampGroupsFetch.predicate = NSPredicate(format: "%K == %@", "stampGroupId", String(stampGroupObjectId))
        stampGroupsFetch.fetchLimit = 1

        let fetchedStampGroupArray: [OwnedStampGroup]

        do {
            fetchedStampGroupArray = try managedObjectContext.fetch(stampGroupsFetch) as? [OwnedStampGroup] ?? []
        } catch {
            fatalError("Failed to update tables: \(error)")
        }

        if fetchedStampGroupArray.count != 0 {
            return fetchedStampGroupArray.first
        }

        let newOwnedStampGroup = OwnedStampGroup(context: managedObjectContext)
        newOwnedStampGroup.id = UUID()
        newOwnedStampGroup.stampGroupId = stampGroupObjectId
        newOwnedStampGroup.ownedStampsCounter = 0

        do {
            try managedObjectContext.save()
        } catch {
            fatalError("Failed to update tables: \(error)")
        }
        managedObjectContext.refresh(newOwnedStampGroup, mergeChanges: true)

        return newOwnedStampGroup
    }

    /// Creates and returns a new entity object.
    ///
    /// - Returns: The newly created entity object.
    ///
    /// Checks if the entity object already exists and returns it. If it does not exist, it creates a new entity object and returns it.
    func createOwnedEntity() -> OwnedEntity? {
        let entityFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "OwnedEntity")
        entityFetch.predicate = NSPredicate(format: "%K == %@", "entityId", String(entityId))
        entityFetch.fetchLimit = 1

        let fetchedEntityArray: [OwnedEntity]

        do {
            fetchedEntityArray = try managedObjectContext.fetch(entityFetch) as? [OwnedEntity] ?? []
        } catch {
            fatalError("Failed to update tables: \(error)")
        }

        if fetchedEntityArray.count != 0 {
            return fetchedEntityArray.first
        }
        let newOwnedEntity = OwnedEntity(context: managedObjectContext)
        newOwnedEntity.id = UUID()
        newOwnedEntity.entityId = entityId
        newOwnedEntity.ownedStampsCounter = 0

        do {
            try managedObjectContext.save()
        } catch {
            fatalError("Failed to update tables: \(error)")
        }
        managedObjectContext.refresh(newOwnedEntity, mergeChanges: true)

        return newOwnedEntity
    }
}

extension LibraryConnectionButtonView {
    /// Removes the stamp object from the database.
    ///
    /// Changes the stamp status to not owned, by removing it from the owned database.
    /// It subtracks a value from the total owned stamps counter from parent stamp group and entity object.
    /// If the total owned stamps counter becomes 0, it also removes the
    /// parent stamp group or / and entity object from the database.
    func removeStampFromOwned() {
        let stampsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "OwnedStamp")
        stampsFetch.predicate = NSPredicate(format: "%K == %@", "stampId", String(stampObjectId))
        stampsFetch.fetchLimit = 1

        do {
            let fetchedStampArray = try managedObjectContext.fetch(stampsFetch) as? [OwnedStamp] ?? []

            guard let fetchedStamp = fetchedStampArray.first
            else { return }

            guard let parentStampGroup = fetchedStamp.ownedStampGroup
            else { return }

            guard let parentEntity = parentStampGroup.ownedEntity
            else { return }

            parentStampGroup.ownedStampsCounter -= 1
            parentEntity.ownedStampsCounter -= 1
            parentStampGroup.removeFromOwnedStamps(fetchedStamp)

            managedObjectContext.delete(fetchedStamp)
            if parentStampGroup.ownedStampsCounter == 0 {
                parentEntity.removeFromOwnedStampGroups(parentStampGroup)
                managedObjectContext.delete(parentStampGroup)
            }

            if parentEntity.ownedStampsCounter == 0 {
                managedObjectContext.delete(parentEntity)
            }

            try managedObjectContext.save()
        } catch {
            fatalError("Failed to update tables: \(error)")
        }
    }

    /// Removes the stamp group object from the database.
    ///
    /// Changes the stamp group status to not owned, by removing it from the owned database.
    /// It also removes all the owned stamp objects that has as children.
    /// It subtracks the total count of it's stamps from the total owned stamps counter from parent entity object.
    /// If the total owned stamps counter becomes 0, it also removes the
    /// parent entity object from the database.
    func removeStampGroupFromOwned() {
        let stampGroupsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "OwnedStampGroup")
        stampGroupsFetch.predicate = NSPredicate(format: "%K == %@", "stampGroupId", String(stampGroupObjectId))
        stampGroupsFetch.fetchLimit = 1

        do {
            let fetchedStampGroupArray = try managedObjectContext.fetch(stampGroupsFetch) as? [OwnedStampGroup] ?? []

            guard let fetchedStampGroup = fetchedStampGroupArray.first
            else { return }

            guard let childrenStamps = fetchedStampGroup.ownedStamps?.allObjects as? [OwnedStamp]
            else { return }

            guard let parentEntity = fetchedStampGroup.ownedEntity
            else { return }

            for stamp in childrenStamps {
                fetchedStampGroup.removeFromOwnedStamps(stamp)
                managedObjectContext.delete(stamp)

                parentEntity.ownedStampsCounter -= 1
            }

            managedObjectContext.delete(fetchedStampGroup)

            if parentEntity.ownedStampsCounter == 0 {
                managedObjectContext.delete(parentEntity)
            }

            try managedObjectContext.save()
        } catch {
            fatalError("Failed to update tables: \(error)")
        }
    }
}
