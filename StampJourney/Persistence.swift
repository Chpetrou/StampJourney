//
//  Persistence.swift
//  StampJourney
//
//  Created by Chris Petrou on 13/5/21.
//

import CoreData

/// Responsible for the connection with the Core Data database.
struct PersistenceController {
    /// A static instance of the *PersistenceController*.
    static let shared = PersistenceController()

    /// A container that encapsulates the Core Data stack in your app.
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "StampJourney")

        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }

        let defaultDirectoryURL = NSPersistentContainer.defaultDirectoryURL()

        // Create a store description for a local store
        let localStoreLocation = defaultDirectoryURL.appendingPathComponent("StampDatabase.sqlite")
        let localStoreDescription = NSPersistentStoreDescription(url: localStoreLocation)
        localStoreDescription.configuration = "StampDatabase"

        // Create a store description for owned local store
        let ownedStoreLocation = defaultDirectoryURL.appendingPathComponent("OwnedDatabase.sqlite")
        let ownedStoreDescription = NSPersistentStoreDescription(url: ownedStoreLocation)
        ownedStoreDescription.configuration = "OwnedDatabase"

        // Update the container's list of store descriptions
        container.persistentStoreDescriptions = [
            localStoreDescription,
            ownedStoreDescription
        ]

        // Load both stores
        container.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError("Could not load persistent stores. \(error!)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    func save() {
        let context = container.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Show some error here
            }
        }
    }
}
