//
//  RouteModifier.swift
//  ArchDemo
//
//  Created by Pere Almendro on 10/2/25.
//

import Foundation
import SwiftUI

/// Manages the navigation logic given a state.
/// The navigation is fired when the state contains value, and dismissed if the state becames nil.
struct Route<Destination: View, State: Sendable>: ViewModifier {
    @Binding var state: State?
    let fullScreen: Bool
    let pushNavigation: Bool
    @ViewBuilder var destination: () -> Destination

    func body(content: Content) -> some View {
        if fullScreen {
            content
                .fullScreenCover(
                    isPresented: .isNotNil($state),
                    content: destination
                )
        } else if pushNavigation {
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
        } else  {
            content
                .sheet(
                    isPresented: .isNotNil($state),
                    content: destination
                )
        }
    }
}
