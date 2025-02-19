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
    case bottomSheet
}

/// Manages the navigation logic given a state.
/// The navigation is fired when the state contains value, and dismissed if the state becames nil.
struct Route<Destination: View, State>: ViewModifier {

    @Binding var state: State?
    let presentation: RoutePresentation
    @ViewBuilder var destination: () -> Destination

    func body(content: Content) -> some View {

        switch presentation {
        case .fullscreen:
            content
                .fullScreenCover(
                    isPresented: .isNotNil($state),
                    content: destination
                )

        case .push:
            // iOS >= 16 push navigation ( requires view to be inside a NavigationStack )
            // this can only be used when the minimum supported version is iOS 16.0
            content
                .navigationDestination(
                    isPresented: .isNotNil($state),
                    destination: destination
                )
            // iOS < 16 push navigation ( requires view to be inside a NavigationView )
//                ZStack {
//                    PushNavigation(
//                        isActive: .isNotNil($state),
//                        destination: destination
//                    )
//                    content
//                }

        case .sheet:
            content
                .sheet(
                    isPresented: .isNotNil($state),
                    content: destination
                )

        case .bottomSheet:
            // NOT IMPLEMENTED
            content
        }
    }
}

extension View {
    func addRoute<Screen: ScreenView>(
        screenType: Screen.Type,
        state: Binding<Screen.ViewM.State?>,
        presentation: RoutePresentation
    ) -> some View {
        modifier(Route(
            state: state,
            presentation: presentation,
            destination: {
                if let state = state.wrappedValue {
                    let viewModel = Screen.ViewM(state: state)
                    Screen(viewModel: viewModel)
                }
            }
        ))
    }
}
