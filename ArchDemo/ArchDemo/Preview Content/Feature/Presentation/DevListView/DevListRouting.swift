//
//  DevListRouter.swift
//  ArchDemo
//
//  Created by Pere Almendro on 31/1/25.
//

import Foundation
import SwiftUI

extension View {
    func addListRoute(
        state: Binding<DevListViewModel.State?>,
        presentation: RoutePresentation
    ) -> some View {
        modifier(
            Route(
                state: state,
                presentation: presentation,
                destination: {
                    if let state = state.wrappedValue {
                        let viewModel = DevListViewModel(
                            state: state
                        )
                        DevListView(viewModel: viewModel)
                    }
                }
            )
        )
    }
}
