//
//  DevDetailRouting.swift
//  ArchDemo
//
//  Created by Pere Almendro on 10/2/25.
//

import Foundation
import SwiftUI

extension View {
    func addDetailRoute(
        state: Binding<DevDetailViewModel.State?>,
        fullScreen: Bool = false,
        pushNavigation: Bool = false
    ) -> some View {
        modifier(
            Route(
                state: state,
                fullScreen: fullScreen,
                pushNavigation: pushNavigation,
                destination: {
                    if let state = state.wrappedValue {
                        let viewModel = DevDetailViewModel(
                            state: state
                        )
                        DevDetailView(viewModel: viewModel)
                    }
                }
            )
        )
    }
}
