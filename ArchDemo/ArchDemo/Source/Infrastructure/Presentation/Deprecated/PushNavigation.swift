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
    @ViewBuilder var destination: () -> Content

    var body: some View {
        NavigationLink(
            isActive: $isActive,
            destination: destination,
            label: { Color.clear.frame(height: .zero) }
        )
    }
}
