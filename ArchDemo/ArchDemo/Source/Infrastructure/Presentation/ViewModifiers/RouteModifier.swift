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
    case sheet
}

/// Manages the navigation logic given a state.
/// The navigation is fired when the state contains value, and dismissed if the state becames nil.
struct RouteModifier<
    Header: View,
    Destination: View
>: ViewModifier {

    @Binding var isPresented: Bool
    let presentation: RoutePresentation
    @ViewBuilder var destination: () -> Destination
    @ViewBuilder var headerContent: () -> Header
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
            // iOS >= 16 push navigation ( requires view to be inside a NavigationStack )
            // this can only be used when the minimum supported version is iOS 16.0
//            content
//                .navigationDestination(
//                    isPresented: $isPresented,
//                    destination: destination
//                )
            // iOS < 16 push navigation ( requires view to be inside a NavigationView )
                ZStack {
                    PushNavigation(
                        isActive: $isPresented,
                        destination: destination,
                        onDismiss: onDismiss
                    )
                    content
                }

        case .sheet:
            content
                .sheet(
                    isPresented: $isPresented,
                    onDismiss: onDismiss,
                    content: destination
                )
        }
    }
}

extension View {
    /// This method is meant to present complete ScreenViews
    /// screen: The Screen type conforming to ScreenView protocol
    /// state: The screen state of the destination view
    /// presentation: The presentation type
    /// headerContent: Only used for RoutePresentation.bottomSheet
    /// onDismiss: Fired on dismissal
    func addRoute<Screen: ScreenView>(
        screen: Screen.Type,
        state: Binding<Screen.ViewM.State?>,
        presentation: RoutePresentation,
        @ViewBuilder headerContent: @escaping () -> some View = { EmptyView() },
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
            headerContent: headerContent,
            onDismiss: onDismiss
        ))
    }

    /// This method is meant to present any View not confirming the ScreenView protocol
    /// State: The state to which bind the presentation
    /// presentation: The presentation type
    /// headerContent: Only used for RoutePresentation.bottomSheet
    /// onDismiss: Fired on dismissal
    func addRoute<T: Sendable>(
        state: Binding<T?>,
        presentation: RoutePresentation,
        @ViewBuilder destination: @escaping () -> some View = { EmptyView() },
        @ViewBuilder headerContent: @escaping () -> some View = { EmptyView() },
        onDismiss: @escaping () -> Void = { }
    ) -> some View {
        modifier(RouteModifier(
            isPresented: .isNotNil(state),
            presentation: presentation,
            destination: destination,
            headerContent: headerContent,
            onDismiss: onDismiss
        ))
    }

    /// This method is meant to present any View not confirming the ScreenView protocol
    /// isPresented: The presentation trigger flag
    /// presentation: The presentation type
    /// headerContent: Only used for RoutePresentation.bottomSheet
    /// onDismiss: Fired on dismissal
    func addRoute(
        isPresented: Binding<Bool>,
        presentation: RoutePresentation,
        @ViewBuilder destination: @escaping () -> some View = { EmptyView() },
        @ViewBuilder headerContent: @escaping () -> some View = { EmptyView() },
        onDismiss: @escaping () -> Void = { }
    ) -> some View {
        modifier(RouteModifier(
            isPresented: isPresented,
            presentation: presentation,
            destination: destination,
            headerContent: headerContent,
            onDismiss: onDismiss
        ))
    }
}
