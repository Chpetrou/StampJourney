//
//  SettingsView.swift
//  StampJourney
//
//  Created by Chris Petrou on 13/5/21.
//

import SwiftUI

/// The view that the settings of the app exist.
struct SettingsView: View {

    @Binding var prefColorScheme: ExtendedColorScheme

    private enum Tabs: Hashable {
        case general
    }
    var body: some View {
        TabView {
            GeneralSettingsView(prefColorScheme: $prefColorScheme)
                .tabItem {
                    Label(LocalizedStringKey("General"), systemImage: "gear")
                }
                .tag(Tabs.general)
        }
        .padding(20)
        .frame(width: 375, height: 150)
    }
}

/// The general tab of the settings view.
///
/// The available settings are:
/// - Reset your library
/// - Change preferred colour scheme
struct GeneralSettingsView: View {
    @AppStorage("showPreview") private var showPreview = true
    @AppStorage("fontSize") private var fontSize = 12.0

    @Environment(\.managedObjectContext) private var viewContext
    @State var isResetCollectionAlertPresented: Bool = false
    @Binding var prefColorScheme: ExtendedColorScheme

    var body: some View {
        Form {
            Section(header: Text("ResetLibraryHeader:", comment: "Header describing the resetting the stamp library")) {
                Button(action: { isResetCollectionAlertPresented.toggle() }, label: {
                    Label("ResetLibrary", systemImage: "square.stack.3d.up.slash.fill")
                })
            }
            Divider()
            Section(header: Text("PreferredColorScheme", comment: "Header describing the choice of colour scheme")) {
                Picker(selection: $prefColorScheme, label: Text("PreferredColorScheme")) {
                    ForEach(ExtendedColorScheme.allCases, id: \.self) { color in
                        Label(LocalizedStringKey(color.name), systemImage: color.systemImage)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .labelsHidden()
            }
        }
        .padding(20)
        .frame(width: 350, height: 100)
        .alert(isPresented: $isResetCollectionAlertPresented) {
            Alert(
                title: Text("ResetLibrary", comment: "Title for resetting the stamp library"),
                message: Text("ResetLibraryMessage", comment: "Message for resetting the stamp library"),
                primaryButton: .cancel(),
                secondaryButton: .destructive(Text("Reset", comment: "Reset button")) {
                    let fetchRequestStamp: NSFetchRequest<NSFetchRequestResult> =
                        NSFetchRequest(entityName: "OwnedStamp")
                    let fetchRequestStampGroup: NSFetchRequest<NSFetchRequestResult> =
                        NSFetchRequest(entityName: "OwnedStampGroup")
                    let fetchRequestEntity: NSFetchRequest<NSFetchRequestResult> =
                        NSFetchRequest(entityName: "OwnedEntity")

                    // Create Batch Delete Request
                    let batchDeleteRequestStamp = NSBatchDeleteRequest(fetchRequest: fetchRequestStamp)
                    let batchDeleteRequestStampGroup = NSBatchDeleteRequest(fetchRequest: fetchRequestStampGroup)
                    let batchDeleteRequestEntity = NSBatchDeleteRequest(fetchRequest: fetchRequestEntity)

                    do {
                        try viewContext.execute(batchDeleteRequestStamp)
                        try viewContext.execute(batchDeleteRequestStampGroup)
                        try viewContext.execute(batchDeleteRequestEntity)

                        UserDefaults.standard.removeObject(forKey: "LibraryCountry")
                        UserDefaults.standard.removeObject(forKey: "CatalogueCountry")
                        UserDefaults.standard.removeObject(forKey: "Continent")

                    } catch {}
                }
            )
        }
    }
}
