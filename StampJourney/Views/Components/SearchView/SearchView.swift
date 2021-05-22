//
//  SearchView.swift
//  StampJourney
//
//  Created by Chris Petrou on 13/5/21.
//

import SwiftUI

/// A search bar for searching the stamp groups.
struct SearchView: View {

    @Binding var searchText: String
    @State var showCancelButton: Bool = false

    var body: some View {
        HStack(spacing: 3) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color(NSColor.selectedTextColor))
            TextField(LocalizedStringKey("Search"), text: $searchText, onEditingChanged: { isEditing in
                if isEditing {
                    showCancelButton = true
                }
            })
            .textFieldStyle(PlainTextFieldStyle())
            .font(.system(size: 12))

            if showCancelButton || searchText != "" {
                Button(action: {
                    searchText = ""
                    showCancelButton = false
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color(NSColor.selectedTextColor))
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(EdgeInsets(top: 3, leading: 4, bottom: 3, trailing: 4))
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color(NSColor.separatorColor), lineWidth: 1)
        )
        .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
    }
}

struct SearchView_Previews: PreviewProvider {
    @State static var searchText: String = ""

    static var previews: some View {
        SearchView(searchText: $searchText)
    }
}

// Used to remove the glare around a textfield when in focus.
extension NSTextField {
    open override var focusRingType: NSFocusRingType {
        get { .none }
        set { }
    }
}
