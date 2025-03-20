//
//  DevListViewModel.swift
//  ArchDemo
//
//  Created by Pere Almendro on 31/1/25.
//

import Foundation
import Dependencies

final class DevListViewModel: ViewModel {
    // MARK: - Dependencies
    @Dependency(\.getDevelopers) private var getDevelopers

    // MARK: - State
    struct State {
        // MARK: - Data
        var developers: [Developer] = []

        // MARK: - Navigations
        var pushDetailState: DevDetailViewModel.State?
        var fullScreenDetailState: DevDetailViewModel.State?
        var sheetDetailState: DevDetailViewModel.State?

        // MARK: - UI & Computed properties
        var loading: Bool = true
        var error: String?

        // MARK: - Lokalised texts
    }

    @Published var state: State
    init(state: State) {
        self.state = state
    }

    // MARK: - Actions
    enum Action {
        case loadData
        case onDeveloperTap(dev: Developer)

        case requestPushNavigation
        case requestSheetNavigation
        case requestFullScreenNavigation
    }
    func send(action: Action) {
        switch action {
        case .loadData:
            loadDevelopers()

        case .onDeveloperTap(_):
            break

        case .requestPushNavigation:
            state.pushDetailState = .init(devId: "1")

        case .requestSheetNavigation:
            state.sheetDetailState = .init(devId: "1")

        case .requestFullScreenNavigation:
            state.fullScreenDetailState = .init(devId: "1")
        }

    }
}

// MARK: - Private

private extension DevListViewModel {

    func loadDevelopers() {
        state.loading = true
        Task {
            Thread.printCurrent(label: "VIEWMODEL")
            var newState = state
            do {
                newState.developers = try await getDevelopers.execute()
            } catch {
                newState.error = error.localizedDescription
            }
            newState.loading = false
            state = newState
        }
    }
}
