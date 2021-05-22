//
//  Helper.swift
//  StampJourney
//
//  Created by Chris Petrou on 13/5/21.
//

import SwiftUI

/// The views available in the sidebar menu.
enum SidebarMenuKeywords: String, CaseIterable {
    case library = "Library"
    case catalogue = "Catalogue"
}

/// Operators to use for filtering when fetching data from the database.
enum Comparisons {
    case equal
    case greaterThanOrEqual
    case lessThanOrEqual
    case greaterThan
    case lessThan
    case notEqual
    case contains
}

/// All available colour schemes to choose for the app appearance.
enum ExtendedColorScheme: CaseIterable {
    case light
    case auto
    case dark

    /// The actual ColorScheme value.
    var value: ColorScheme? {
        switch self {
        case .light:
            return .light
        case .auto:
            return .none
        case .dark:
            return .dark
        }
    }

    /// The string name of the colour scheme.
    var name: String {
        switch self {
        case .light:
            return "Light"
        case .auto:
            return "Auto"
        case .dark:
            return "Dark"
        }
    }

    /// The system image for the colour scheme.
    var systemImage: String {
        switch self {
        case .light:
            return "circle"
        case .auto:
            return "circle.righthalf.fill"
        case .dark:
            return "circle.fill"
        }
    }
}

/// A three-valued logic type.
enum Troolean {
    case `true`
    case `partially`
    case `false`

    /// Toggles the value.
    mutating func toggle() {
        switch self {
        case .true:
            self = .false
        default:
            self = .true
        }
    }

    /// Returns the toggled value.
    /// - Returns: The toggled value.
    func toggleReturn() -> Troolean {
        switch self {
        case .true:
            return .false
        default:
            return .true
        }
    }

    /// Converts the troolean to boolean.
    /// - Returns: A boolean value.
    func toBool() -> Bool {
        switch self {
        case .true:
            return true
        default:
            return false
        }
    }

    /// The string value of the troolean.
    /// - Returns: A string describing the troolean value.
    func toString() -> String {
        switch self {
        case .true:
            return "true"
        case .partially:
            return "partially"
        case .false:
            return "false"
        }
    }
}

/// The available types to use as a button connecting to the database.
enum StampButtonType {
    case stamp
    case stampGroup
}

/// A structure for creating parameters to use for filtering.
struct FilterParameter {
    /// The name of the field requested for filtering.
    var key: String
    /// The operator used for filtering.
    var comparison: Comparisons
    /// The value to use for filtering.
    var value: String
}

/// A generic helper struct.
struct Helper {
    /// Creates a predicate for use with the filtering lists.
    /// - Parameter parameter: A filter parameter structure.
    /// - Returns: A predicate for filtering the database.
    static func createPredicate(parameter: FilterParameter) -> NSPredicate {
        switch parameter.comparison {
        case .equal:
            return NSPredicate(format: "%K == %@", parameter.key, parameter.value)
        case .greaterThanOrEqual:
            return NSPredicate(format: "%K >= %@", parameter.key, parameter.value)
        case .lessThanOrEqual:
            return NSPredicate(format: "%K <= %@", parameter.key, parameter.value)
        case .greaterThan:
            return NSPredicate(format: "%K > %@", parameter.key, parameter.value)
        case .lessThan:
            return NSPredicate(format: "%K < %@", parameter.key, parameter.value)
        case .notEqual:
            return NSPredicate(format: "%K != %@", parameter.key, parameter.value)
        case .contains:
            return NSPredicate(format: "%K CONTAINS[c] %@", parameter.key, parameter.value)
        }
    }
}

public extension Color {
    #if os(macOS)
    /// A dynamic background colour converted from NSColor.
    static let background = Color(NSColor.windowBackgroundColor)
    /// A dynamic secondary background colour converted from NSColor.
    static let secondaryBackground = Color(NSColor.underPageBackgroundColor)
    /// A dynamic tetriary background colour converted from NSColor.
    static let tertiaryBackground = Color(NSColor.controlBackgroundColor)
    #else
    /// A dynamic background colour converted from UIColor.
    static let background = Color(UIColor.systemBackground)
    /// A dynamic secondary background colour converted from UIColor.
    static let secondaryBackground = Color(UIColor.secondarySystemBackground)
    /// A dynamic tetriary background colour converted from UIColor.
    static let tertiaryBackground = Color(UIColor.tertiarySystemBackground)
    #endif
}
