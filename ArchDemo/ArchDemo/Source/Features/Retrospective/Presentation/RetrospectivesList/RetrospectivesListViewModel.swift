//
//  RetrospectivesListViewModel.swift
//  ArchDemo
//
//  Created by Pere Almendro on 21/3/25.
//

import Foundation

final class RetrospectivesListViewModel: ViewModel {
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
        case onAddRetrospectiveRequested
    }
    func send(action: Action) {
        switch action {
        case .loadData:
            break
        case .onAddRetrospectiveRequested:
            break
        }
    }
}
