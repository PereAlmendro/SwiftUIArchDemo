//
//  PushNavigation.swift
//  ArchDemo
//
//  Created by Pere Almendro on 10/2/25.
//
import SwiftUI

@available(*, deprecated, message: "To be deleted when minimum supported version >= iOS 16.0")
struct PushNavigation<Content: View, Label: View>: View {
    @Binding var isActive: Bool
    @ViewBuilder private var destination: () -> Content
    @ViewBuilder private var label: () -> Label

    init(
        isActive: Binding<Bool>,
        @ViewBuilder destination: @escaping () -> Content,
        @ViewBuilder label: @escaping () -> Label = { Color.clear.frame(height: .zero) }
    ) {
        _isActive = isActive
        self.destination = destination
        self.label = label
    }

    var body: some View {
        NavigationLink(
            isActive: $isActive,
            destination: { destination() },
            label: label
        )
    }
}
