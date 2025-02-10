//
//  DevDetailViewModel.swift
//  ArchDemo
//
//  Created by Pere Almendro on 31/1/25.
//

import Foundation
import Dependencies

final class DevDetailViewModel: ViewModel {
    // MARK: - Dependencies
    @Dependency(\.getDeveloperDetail) var getDetail

    // MARK: - State
    struct State {
        // MARK: - Data
        let devId: String
        var devDetail: DeveloperDetail?

        // MARK: - Navigations

        // MARK: - UI & Computed properties
        var loading: Bool = true
        var error: String?
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
            loadDetail()
        }
    }
}

// MARK: - Private

private extension DevDetailViewModel {

    func loadDetail() {
        state.loading = true
        Task {
            try? await Task.sleep(for: .seconds(1))
            var newState = state
            do {
                newState.devDetail = try await getDetail(state.devId)
            } catch {
                newState.error = error.localizedDescription
            }
            newState.loading = false
            state = newState
        }
    }
}
