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
    @StateObject private var viewModel: MainViewModel
    init(viewModel: MainViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Button(action: {
                    viewModel.send(action: .navigate)
                }, label: {
                    Text("Start flow")
                })
                Spacer()
            }
            .toolbar("Main", leftItems: [
                .init(type: .close, action: {
                    dismiss()
                })
            ])
            .addRoute(
                screen: PageOneView.self,
                state: $viewModel.state.pageState,
                presentation: .fullscreen
            )
        }
        .environmentObject(viewModel)
    }
}
