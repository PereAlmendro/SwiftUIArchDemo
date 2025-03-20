//
//  RouteModifier.swift
//  ArchDemo
//
//  Created by Pere Almendro on 10/2/25.
//

import Foundation
import SwiftUI

enum RoutePresentation {
    case fullscreen
    case push
    case sheet(Set<PresentationDetent> = [])
}

/// Manages the navigation logic given a state.
/// The navigation is fired when the state contains value, and dismissed if the state becames nil.
struct RouteModifier<Destination: View>: ViewModifier {

    @Binding var isPresented: Bool
    let presentation: RoutePresentation
    @ViewBuilder var destination: () -> Destination
    var onDismiss: () -> Void = { }

    func body(content: Content) -> some View {

        switch presentation {
        case .fullscreen:
            content
                .fullScreenCover(
                    isPresented: $isPresented,
                    onDismiss: onDismiss,
                    content: destination
                )

        case .push:
            if #available(iOS 16, *) {
                content
                    .navigationDestination(
                        isPresented: $isPresented,
                        destination: destination
                    )
            } else {
                ZStack {
                    PushNavigation(
                        isActive: $isPresented,
                        destination: destination,
                        onDismiss: onDismiss
                    )
                    content
                }
            }

        case .sheet(let detents):
            content
                .sheet(
                    isPresented: $isPresented,
                    onDismiss: onDismiss,
                    content: {
                        destination()
                            .presentationDetents(detents)
                    }
                )
        }
    }
}

extension View {
    /// This method is meant to present complete ScreenViews
    /// screen: The Screen type conforming to ScreenView protocol
    /// state: The screen state of the destination view
    /// presentation: The presentation type
    /// onDismiss: Fired on dismissal
    func addRoute<Screen: ScreenView>(
        screen: Screen.Type,
        state: Binding<Screen.ViewM.State?>,
        presentation: RoutePresentation,
        onDismiss: @escaping () -> Void = { }
    ) -> some View {
        modifier(RouteModifier(
            isPresented: .isNotNil(state),
            presentation: presentation,
            destination: {
                if let state = state.wrappedValue {
                    let viewModel = Screen.ViewM(state: state)
                    Screen(viewModel: viewModel)
                }
            },
            onDismiss: onDismiss
        ))
    }

    /// This method is meant to present any View not confirming the ScreenView protocol
    /// State: The state to which bind the presentation
    /// presentation: The presentation type
    /// onDismiss: Fired on dismissal
    func addRoute<T: Sendable>(
        state: Binding<T?>,
        presentation: RoutePresentation,
        @ViewBuilder destination: @escaping () -> some View = { EmptyView() },
        onDismiss: @escaping () -> Void = { }
    ) -> some View {
        modifier(RouteModifier(
            isPresented: .isNotNil(state),
            presentation: presentation,
            destination: destination,
            onDismiss: onDismiss
        ))
    }

    /// This method is meant to present any View not confirming the ScreenView protocol
    /// isPresented: The presentation trigger flag
    /// presentation: The presentation type
    /// onDismiss: Fired on dismissal
    func addRoute(
        isPresented: Binding<Bool>,
        presentation: RoutePresentation,
        @ViewBuilder destination: @escaping () -> some View = { EmptyView() },
        onDismiss: @escaping () -> Void = { }
    ) -> some View {
        modifier(RouteModifier(
            isPresented: isPresented,
            presentation: presentation,
            destination: destination,
            onDismiss: onDismiss
        ))
    }
}
