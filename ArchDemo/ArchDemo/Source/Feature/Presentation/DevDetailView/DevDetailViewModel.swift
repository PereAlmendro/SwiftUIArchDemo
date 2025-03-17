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
        var mainState: MainViewModel.State?

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
        case navigateToMain
    }
    func send(action: Action) {
        switch action {
        case .loadData:
            loadDetail()
        case .navigateToMain:
            state.mainState = .init()
        }
    }
}

// MARK: - Private

private extension DevDetailViewModel {

    func loadDetail() {
        state.loading = true
        Task {
            var newState = state
            do {
                newState.devDetail = try await getDetail.execute(id: state.devId)
            } catch {
                newState.error = error.localizedDescription
            }
            newState.loading = false
            state = newState
        }
    }
}
