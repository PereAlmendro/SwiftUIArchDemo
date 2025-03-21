//
//  RetrospectivesListView.swift
//  ArchDemo
//
//  Created by Pere Almendro on 20/3/25.
//

import Foundation
import SwiftUI

struct RetrospectivesListView: ScreenView {
    typealias ViewM = RetrospectivesListViewModel
    @StateObject var viewModel: RetrospectivesListViewModel
    init(viewModel: RetrospectivesListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Retro feature")
                }
            }
            .toolbar(
                viewModel.state.pageTitle,
                leftItems: [
                    .init(type: .close, action: { dismiss() })
                ],
                rightItems: [
                    .init(
                        type: .text(LocalizedStringKey("add")),
                        action: {
                            viewModel.send(action: .onAddRetrospectiveRequested)
                        }
                    )
                ]
            )
        }
    }
}
