//
//  ToggleSidebarButton.swift
//  StampJourney
//
//  Created by Chris Petrou on 13/5/21.
//

import SwiftUI

/// Toolbar button for toggling the sidebar.
struct ToggleSidebarButton: View {
    var body: some View {
        Button(action: toggleSidebar) {
            Image(systemName: "sidebar.left")
                .help("ToggleSidebarHelper")
        }
    }
}

/// Toggle Sidebar Function
private func toggleSidebar() {
    NSApp.keyWindow?.firstResponder?
        .tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
}
