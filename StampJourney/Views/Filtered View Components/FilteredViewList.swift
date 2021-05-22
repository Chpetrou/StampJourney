//
//  FilteredViewList.swift
//  StampJourney
//
//  Created by Chris Petrou on 13/5/21.
//

import SwiftUI

/// A generic list enclosure for filtering objects.
struct FilteredListWithParameters<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var elements: FetchedResults<T> { fetchRequest.wrappedValue }

    // Called once per item in the list.
    let content: (T) -> Content

    var body: some View {
        List(elements, id: \.self) { element in
            self.content(element)
        }
        .id(UUID())
    }

    /// The parameters for the filtered list.
    /// - Parameters:
    ///   - filterParameters: The filter parameters for the list.
    ///   - content: The content to be shown.
    init(filterParameters: [FilterParameter], @ViewBuilder content: @escaping (T) -> Content) {
        var predicateArray: [NSPredicate] = []

        for parameter in filterParameters {
            predicateArray.append(Helper.createPredicate(parameter: parameter))
        }

        fetchRequest = FetchRequest<T>(
            entity: T.entity(),
            sortDescriptors: [],
            predicate: NSCompoundPredicate(andPredicateWithSubpredicates: predicateArray))
        self.content = content
    }
}

/// A  list enclosure for filtering the stamp groups.
struct FilteredStampGroupListWithParameters<Content: View>: View {
    var fetchRequest: FetchRequest<StampGroup>
    var elements: FetchedResults<StampGroup> { fetchRequest.wrappedValue }

    // Called once per item in the list.
    let content: (StampGroup) -> Content
    var refinedElementList: [StampGroup] {
        var list: [StampGroup] = []
        for stampGroup in elements {
            if stampGroup.isOwned == .true || stampGroup.isOwned == .partially {
                list.append(stampGroup)
            }
        }
        return list
    }

    var body: some View {
        List(refinedElementList, id: \.self) { element in
            self.content(element)
        }
        .id(UUID())
    }

    /// The parameters for the filtered list.
    /// - Parameters:
    ///   - filterParameters: The filter parameters for the list.
    ///   - content: The content to be shown.
    init(filterParameters: [FilterParameter], @ViewBuilder content: @escaping (StampGroup) -> Content) {
        var predicateArray: [NSPredicate] = []

        for parameter in filterParameters {
            predicateArray.append(Helper.createPredicate(parameter: parameter))
        }

        fetchRequest = FetchRequest<StampGroup>(
            entity: StampGroup.entity(),
            sortDescriptors: [],
            predicate: NSCompoundPredicate(andPredicateWithSubpredicates: predicateArray))
        self.content = content
    }
}

/// A generic ordered picker view (used to show ordered continents).
struct OrderedContinentPicker<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>

    let content: (T) -> Content

    var body: some View {
        ForEach(fetchRequest.wrappedValue, id: \.self) { element in
            self.content(element)
        }
    }

    /// The parameters for the filtered list.
    /// - Parameters:
    ///   - sortKey: The field to be ordered.
    ///   - ascending: The direction of the ordering.
    ///   - content: The content to be shown.
    init(sortKey: String, ascending: Bool, @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(
            entity: T.entity(),
            sortDescriptors: [NSSortDescriptor(key: sortKey, ascending: ascending)])
        self.content = content
    }
}
