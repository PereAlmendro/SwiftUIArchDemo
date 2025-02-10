//
//  Bindingbool+Additions.swift
//  ArchDemo
//
//  Created by Pere Almendro on 31/1/25.
//

import SwiftUI

extension Binding<Bool> {
    /// Create a binding bool that reacts to the nullability of the received object
    static func isNotNil<T: Sendable>(_ object: Binding<T?>) -> Self {
        .init(
            get: { object.wrappedValue != nil },
            set: { if !$0 { object.wrappedValue = nil } }
        )
    }

    /// Create a binding bool negating the given binding bool
    static func not(_ object: Binding<Bool>) -> Self {
        .init(
            get: { !object.wrappedValue },
            set: { object.wrappedValue = !$0 }
        )
    }

    /// Create a binding bool form an optional one where the null value is converted to false.
    static func safeUnwrapped(_ object: Binding<Bool?>) -> Self {
        .init(
            get: { object.wrappedValue ?? false },
            set: { object.wrappedValue = $0 }
        )
    }
}
