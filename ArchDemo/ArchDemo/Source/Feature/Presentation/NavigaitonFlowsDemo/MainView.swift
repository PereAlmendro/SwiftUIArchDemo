//
//  MainScreen.swift
//  ArchDemo
//
//  Created by Pere Almendro on 17/3/25.
//

import Foundation
import SwiftUI
import Dependencies

final class MainViewModel: ViewModel {
    // MARK: - Dependencies
    // MARK: - State
    struct State {
        // MARK: - Data
        // MARK: - Navigations
        var pageState: PageOneViewModel.State?
        // MARK: - UI & Computed properties
    }
    @Published var state: State
    init(state: State) {
        self.state = state
    }

    // MARK: - Actions
    enum Action {
        case navigate
        case endFlow
    }
    func send(action: Action) {
        switch action {
        case .navigate:
            state.pageState = .init()
        case .endFlow:
            state.pageState = nil
        }
    }
}

struct MainView: ScreenView {
    typealias ViewM = MainViewModel
    @StateObject var viewModel: MainViewModel
    init(viewModel: MainViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Button(action: {
                    viewModel.send(action: .navigate)
                }, label: {
                    Text("Navigate to page 1")
                })
                Spacer()
            }
            .addRoute(
                screen: PageOneView.self,
                state: $viewModel.state.pageState,
                presentation: .fullscreen
            )
        }
        .environmentObject(viewModel)
    }
}
