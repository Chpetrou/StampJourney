//
//  StampJourneyApp.swift
//  StampJourney
//
//  Created by Chris Petrou on 13/5/21.
//

import SwiftUI

@main
struct StampJourneyApp: App {
    /// A static instance of the PersistenceController.
    let persistenceController = PersistenceController.shared

    /// A wrapper view model containing other view models.
    @StateObject var groupViewModel: GroupViewModel = GroupViewModel(viewContext: PersistenceController.shared.container.viewContext)
    /// A view model for the settings view.
    @StateObject var settingsViewModel: SettingsViewModel = SettingsViewModel()
    /// The current phase of the scene.
    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(groupViewModel)
                .preferredColorScheme(settingsViewModel.prefColorScheme.value)
        }
        .windowToolbarStyle(UnifiedWindowToolbarStyle(showsTitle: false))
        .onChange(of: scenePhase) { _ in
            persistenceController.save()
        }
        .commands {
            SidebarCommands()
        }
        #if os(macOS)
        Settings {
            SettingsView(prefColorScheme: $settingsViewModel.prefColorScheme)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        #endif
    }
}
