//
//  FilterView.swift
//  StampJourney
//
//  Created by Chris Petrou on 13/5/21.
//

import SwiftUI

/// A view that has filters for the stamp groups.
///
/// Currently, it can only filter by a range of years.
struct FilterView: View {
    @EnvironmentObject var groupViewModel: GroupViewModel
    @Binding var isLibrary: Bool

    /// Returns the view model used.
    var viewModel: Binding<BaseViewModel> {
        if isLibrary {
            return $groupViewModel.libraryViewModel
        }
        return $groupViewModel.filterViewModel
    }

    var body: some View {
        HStack {
            Group {
                Toggle("Enable", isOn: viewModel.projectedValue.dateFilterToggle)
                    .labelsHidden()
                HStack {
                    Group {
                        VStack {
                            Text(LocalizedStringKey("From"), comment: "Label denoting the starting date")
                            Picker("From", selection: viewModel.projectedValue.fromDate) {
                                ForEach(viewModel.wrappedValue.fromDataRange, id: \.self) {
                                    Text(String($0))
                                }
                            }
                            .labelsHidden()
                            .pickerStyle(MenuPickerStyle())
                            .frame(width: 65)
                            .clipped()
                        }

                        VStack {
                            Text(LocalizedStringKey("To"), comment: "Label denoting the ending date")
                            Picker("To", selection: viewModel.projectedValue.toDate) {
                                ForEach(viewModel.wrappedValue.toDataRange, id: \.self) {
                                    Text(String($0))
                                }
                            }
                            .labelsHidden()
                            .pickerStyle(MenuPickerStyle())
                            .frame(width: 65)
                            .clipped()
                        }
                    }
                    .disabled(!viewModel.wrappedValue.dateFilterToggle)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(lineWidth: 2)
                        .foregroundColor(viewModel.wrappedValue.dateFilterToggle ? .green : .gray)
                )
            }
        }
        .frame(width: 210, height: 100)
    }
}
