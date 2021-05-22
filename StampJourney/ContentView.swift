//
//  ContentView.swift
//  StampJourney
//
//  Created by Chris Petrou on 13/5/21.
//

import SwiftUI
import CoreData

/// First view of the app.
struct ContentView: View {

    /// The view context used for interaction with the database.
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        NavigationView {
            SidebarView()
                .toolbar {
                    ToolbarItem {
                        ToggleSidebarButton()
                    }
                }
            Text("NoSidebar", comment: "Informing the user that no sidebar item is selected")
            Text("NoRow", comment: "Informing the user that no row item is selected")
        }
    }
}
