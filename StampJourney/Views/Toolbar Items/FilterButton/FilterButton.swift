//
//  FilterButton.swift
//  StampJourney
//
//  Created by Chris Petrou on 13/5/21.
//

import SwiftUI

/// A button that shows the filter view.
struct FilterButton: View {

    @Binding var showingDetailFilter: Bool
    @Binding var isLibrary: Bool

    var body: some View {
        Button(action: { showingDetailFilter.toggle() }) {
            Label("Filter", systemImage: "line.horizontal.3.decrease.circle")
        }
        .popover(isPresented: $showingDetailFilter, arrowEdge: .bottom) {
            FilterView(isLibrary: $isLibrary)
        }
    }
}
