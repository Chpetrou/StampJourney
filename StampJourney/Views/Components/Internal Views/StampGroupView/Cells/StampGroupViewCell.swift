//
//  StampGroupViewCell.swift
//  StampJourney
//
//  Created by Chris Petrou on 13/5/21.
//

import SwiftUI

extension StampGroupViewCell {
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {

            Color.background

            VStack {
                HStack {
                    NavigationLink(destination: StampDetailView(stampGroup: $stampGroup, refresh: $refresh), isActive: $activeRow) {

                        VStack(alignment: .leading) {
                            Text(stampGroup.wrappedName)
                                .font(.headline)
                                .fontWeight(.bold)
                                .padding(.bottom, 5)

                            Text(stampGroup.wrappedType)
                                .padding(.bottom, 5)

                            CountryEnclosure {
                                HStack(alignment: .center) {
                                    Image(systemName: "mappin")
                                    Text(LocalizedStringKey(stampGroupCountry))
                                }
                            }
                            .padding(.bottom, 5)

                            HStack {
                                VStack {
                                    Text("From")
                                    DateEnclosure(fromToDate: Int(stampGroup.fromDateIssued))
                                }
                                VStack {
                                    Text("To")
                                    DateEnclosure(fromToDate: Int(stampGroup.toDateIssued))
                                }
                            }
                        }
                        .foregroundColor(colorScheme == ColorScheme.light ? .black : .white)
                        .padding(.horizontal, 5)
                    }
                }
                .padding(15)
                .padding(.bottom, 40)
            }
            LibraryConnectionButtonView(
                stampGroupObject: $stampGroup,
                entity: $stampGroup.stampEntity,
                isOwned: $isOwned,
                refresh: $refresh
            )
            .padding(.top, 15)
            .padding(.bottom, 15)
            .padding(.leading, 20)
        }
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}
