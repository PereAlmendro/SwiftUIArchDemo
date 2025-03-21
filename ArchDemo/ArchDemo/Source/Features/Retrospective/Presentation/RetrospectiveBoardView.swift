//
//  RetrospectiveBoardView.swift
//  ArchDemo
//
//  Created by Pere Almendro on 20/3/25.
//

import Foundation
import SwiftUI

final class RetrospectiveBoardViewModel: ViewModel {
    // MARK: - Dependencies
    // MARK: - State
    struct State {
        // MARK: - Data
        var pageTitle: String = "Retrospectives"
        // MARK: - Navigations
        // MARK: - UI & Computed properties
    }
    @Published var state: State
    init(state: State) {
        self.state = state
    }

    // MARK: - Actions
    enum Action {
        case loadData
    }
    func send(action: Action) {
        switch action {
        case .loadData:
            break
        }
    }
}

struct RetrospectiveBoardView: ScreenView {
    typealias ViewM = RetrospectiveBoardViewModel
    @StateObject var viewModel: RetrospectiveBoardViewModel
    init(viewModel: RetrospectiveBoardViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("retrospective_title")
                }
            }
            .toolbar(
                viewModel.state.pageTitle,
                leftItems: [
                    .init(type: .close, action: { dismiss() })
                ],
                rightItems: [
                    .init(
                        type: .custom({ RetroTimerView() })
                    )
                ]
            )
        }
    }
}
