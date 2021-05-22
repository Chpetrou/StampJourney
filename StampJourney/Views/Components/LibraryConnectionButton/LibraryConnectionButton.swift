//
//  LibraryConnectionButton.swift
//  StampJourney
//
//  Created by Chris Petrou on 13/5/21.
//

import SwiftUI

/// Creates a button that can add stamps to the database.
///
/// The button in addition to adding stamps or/and stamp groups to the database
/// shows it's state which can depending on it's type be between:
///
/// **Stamp Group**
/// - *Owned* = You have all of the stamps
/// - *Partially Owned* = You have some of the stamps
/// - *Add to Collection* = You have no stamps
///
/// **Stamp**
/// - *Owned* = You own the stamp
/// - *Add to Collection* = You do not own the stamp
struct LibraryConnectionButtonView: View {
    @Binding var isStampOwned: Bool
    @Binding var isStampGroupOwned: Troolean
    @Binding var stampObject: Stamp
    @Binding var stampGroupObject: StampGroup
    @Binding var entityObject: Entity?
    @Binding var refresh: Bool

    var stampObjectId: Int64 {
        stampObject.id
    }
    var stampGroupObjectId: Int64 {
        stampGroupObject.id
    }
    var entityId: Int64 {
        entityObject?.id ?? 0
    }

    @EnvironmentObject var groupViewModel: GroupViewModel

    var buttonType: StampButtonType = .stamp
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var isHovered = false

    /// Initializes the button for stamp usage.
    ///
    /// - Parameters:
    ///   - stamp: The stamp object that the button is used for.
    ///   - stampGroup: The stamp group object for the aforementioned stamp object.
    ///   - entity: The entity object for the aforementioned stamp group object.
    ///   - isOwned: Indicates the ownership state of the stamp.
    init(stampObject stamp: Binding<Stamp>, stampGroup: Binding<StampGroup>, entity: Binding<Entity?>?, isOwned: Binding<Bool>, refresh: Binding<Bool>) {
        self.buttonType = .stamp
        self._stampObject = stamp
        self._isStampOwned = isOwned
        self._stampGroupObject = stampGroup
        self._entityObject = entity ?? .constant(nil)
        self._isStampGroupOwned = .constant(.false)
        self._refresh = refresh
    }

    /// Initializes the button for stamp group usage.
    ///
    /// - Parameters:
    ///   - stampGroup: The stamp group object that the button is used for.
    ///   - entity: The entity object for the aforementioned stamp group object.
    ///   - isOwned: Indicates the ownership state of the stamp group.
    init(stampGroupObject stampGroup: Binding<StampGroup>, entity: Binding<Entity?>?, isOwned: Binding<Troolean>, refresh: Binding<Bool>) {
        self.buttonType = .stampGroup
        self._stampGroupObject = stampGroup
        self._stampObject = .constant(Stamp())
        self._isStampOwned = .constant(false)
        self._entityObject = entity ?? .constant(nil)
        self._isStampGroupOwned = isOwned
        self._refresh = refresh
    }

    var body: some View {
        Button(action: {
            switch buttonType {
            case .stampGroup:
                updateOwnedStampGroup(isStampGroupOwned: isStampGroupOwned, stampGroup: stampGroupObject)
                isStampGroupOwned.toggle()
            case .stamp:
                updateOwnedStamp(isStampOwned: isStampOwned, stamp: stampObject)
                isStampOwned.toggle()
            }

            //Used as a workaround for refreshing the screen and recalling the components, until I find a proper solution.
            refresh.toggle()
        }, label: {
            HStack {
                switch buttonType {
                case .stampGroup:
                    Image(systemName: stampGroupSystemImage)
                    if isHovered {
                        Text(LocalizedStringKey(stampGroupText), comment: "Text describing the status of the stamp group ownership")
                    }
                case .stamp:
                    Image(systemName: stampSystemImage)
                    Text(LocalizedStringKey(stampText), comment: "Text describing the status of the stamp ownership")
                }
            }
            .padding(5)
            .background(buttonColor)
            .cornerRadius(5)
            .onHover { hovering in
                withAnimation {
                    isHovered = hovering
                }
            }
            .foregroundColor(.accentColor)
        })
        .buttonStyle(PlainButtonStyle())
    }
}

extension Notification.Name {
    public static let kRefresh = Notification.Name("refresh")
}
