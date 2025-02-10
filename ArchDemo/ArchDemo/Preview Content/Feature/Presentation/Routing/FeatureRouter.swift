//
//  FeatureRouter.swift
//  ArchDemo
//
//  Created by Pere Almendro on 10/2/25.
//

import Foundation
import SwiftUI

struct FeatureRouterModifier: ViewModifier {
    @Binding var detailState: DevDetailViewModel.State?
    @Binding var listState: DevListViewModel.State?

    func body(content: Content) -> some View {
        content
            .addListRoute(state: $listState)
            .addDetailRoute(state: $detailState)
    }
}

extension View {
    func addRouter(
        detailState: Binding<DevDetailViewModel.State?> = .constant(nil),
        listState: Binding<DevListViewModel.State?> = .constant(nil)
    ) -> some View {
        modifier(
            FeatureRouterModifier(
                detailState: detailState,
                listState: listState
            )
        )
    }
}
