//
//  SidebarView.swift
//  StampJourney
//
//  Created by Chris Petrou on 13/5/21.
//

import SwiftUI

/// The sidebar view.
struct SidebarView: View {
    @State private var isDefaultItemActive = true

    let notification = NotificationCenter.default.addObserver(forName: .kRefresh, object: nil, queue: .main, using: {_ in
        
    })

    var body: some View {
        List {
            Section(header: Text("MainMenu", comment: "Name of the main section")) {
                NavigationLink(destination: StampGroupView(isLibrary: true)) {
                    Label(LocalizedStringKey(SidebarMenuKeywords.library.rawValue), systemImage: "books.vertical")
                }
                NavigationLink(destination: StampGroupView(isLibrary: false), isActive: $isDefaultItemActive) {
                    Label(LocalizedStringKey(SidebarMenuKeywords.catalogue.rawValue), systemImage: "list.bullet")
                }
            }
        }
        .listStyle(SidebarListStyle())
        .frame(minWidth: 150)
        .navigationTitle("Explore")
    }

    var isLibrary: Bool {
        return !isDefaultItemActive
    }
}
