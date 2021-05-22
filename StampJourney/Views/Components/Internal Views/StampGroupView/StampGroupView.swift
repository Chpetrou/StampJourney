//
//  StampGroupView.swift
//  StampJourney
//
//  Created by Chris Petrou on 13/5/21.
//

import SwiftUI

/// A list of stamp group cells.
struct StampGroupView: View {
    @State var isLibrary: Bool
    @State var showingDetailFilter = false
    @EnvironmentObject var groupViewModel: GroupViewModel
    /// Used as a workaround for refreshing the screen and recalling the components, until I find a proper solution.
    @State private var refresh: Bool = false

    /// Returns the view model used.
    var viewModel: Binding<BaseViewModel> {
        if isLibrary {
            return $groupViewModel.libraryViewModel
        }
        return $groupViewModel.filterViewModel
    }

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            if viewModel.wrappedValue.selectedCountryId == 0 {
                Text("SelectCountry", comment: "Guiding the user to select a country")
            } else {
                SearchView(searchText: viewModel.projectedValue.searchText)
                Divider()
                if isLibrary {
                    FilteredStampGroupListWithParameters(filterParameters: (viewModel.wrappedValue.parametersArray)) { (stampGroup: StampGroup) in
                        if stampGroup.isOwned == .true || stampGroup.isOwned == .partially {
                            if refresh {
                                StampGroupViewCell(stampGroup: stampGroup, isOwned: stampGroup.isOwned, refresh: $refresh)
                            } else {
                                StampGroupViewCell(stampGroup: stampGroup, isOwned: stampGroup.isOwned, refresh: $refresh)
                            }
                        }
                    }
                } else {
                    FilteredListWithParameters(filterParameters: (viewModel.wrappedValue.parametersArray)) { (stampGroup: StampGroup) in
                        if refresh {
                            StampGroupViewCell(stampGroup: stampGroup, isOwned: stampGroup.isOwned, refresh: $refresh)
                        } else {
                            StampGroupViewCell(stampGroup: stampGroup, isOwned: stampGroup.isOwned, refresh: $refresh)
                        }
                    }

                }
            }
        }
        .toolbar {
            ToolbarItem {
                ContinentPicker(
                    selectedContinent: viewModel.projectedValue.selectedContinent,
                    selectedCountry: viewModel.projectedValue.selectedCountry
                )
                .help("ChooseContinentHelper")
            }
            ToolbarItem {
                CountryPicker(
                    selectedContinent: viewModel.projectedValue.selectedContinent,
                    selectedCountry: viewModel.projectedValue.selectedCountry,
                    isLibrary: $isLibrary
                )
                .help("ChooseCountryHelper")
            }
            ToolbarItem {
                FilterButton(showingDetailFilter: $showingDetailFilter, isLibrary: $isLibrary)
                    .help("FilterHelper")
            }
        }
    }

    /// Sets the variable if its used for the library or the catalogue view.
    /// - Parameter isLibrary: Boolean value for if it is used for the library view.
    init(isLibrary: Bool) {
        self.isLibrary = isLibrary
    }
}
