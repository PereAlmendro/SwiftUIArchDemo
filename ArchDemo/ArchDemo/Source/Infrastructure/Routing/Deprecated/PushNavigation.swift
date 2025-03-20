//
//  PushNavigation.swift
//  ArchDemo
//
//  Created by Pere Almendro on 10/2/25.
//
import SwiftUI

@available(*, deprecated, message: "To be deleted when minimum supported version >= iOS 16.0")
struct PushNavigation<Content: View>: View {
    @Binding var isActive: Bool
    @ViewBuilder private var destination: () -> Content
    private var onDismiss: () -> Void

    init(
        isActive: Binding<Bool>,
        @ViewBuilder destination: @escaping () -> Content,
        onDismiss: @escaping () -> Void = { }
    ) {
        _isActive = isActive
        self.destination = destination
        self.onDismiss = onDismiss
    }

    var body: some View {
        NavigationLink(
            isActive: $isActive,
            destination: {
                destination()
                    .navigationBarHidden(true)
                    .onDisappear(perform: onDismiss)
            },
            label: { Color.clear.frame(height: .zero) }
        )
    }
}
