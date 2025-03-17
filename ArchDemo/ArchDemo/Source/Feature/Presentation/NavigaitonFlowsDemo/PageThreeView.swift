//
//  PageThreeView.swift
//  ArchDemo
//
//  Created by Pere Almendro on 17/3/25.
//

import Foundation
import SwiftUI

final class PageThreeViewModel: ViewModel {
    // MARK: - Dependencies
    // MARK: - State
    struct State {
        // MARK: - Data
        let title: String = "Page three"
        // MARK: - Navigations
        var pageState: PageFourViewModel.State?
        // MARK: - UI & Computed properties
    }
    @Published var state: State
    init(state: State) {
        self.state = state
    }

    // MARK: - Actions
    enum Action {
        case navigate
    }
    func send(action: Action) {
        switch action {
        case .navigate:
            state.pageState = .init()
        }
    }
}

struct PageThreeView: ScreenView {
    typealias ViewM = PageThreeViewModel
    @StateObject var viewModel: PageThreeViewModel
    init(viewModel: PageThreeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text(viewModel.state.title)
                Button(action: {
                    viewModel.send(action: .navigate)
                }, label: {
                    Text("Navigate to page 4")
                })
                Spacer()
            }
            .navigationTitle(viewModel.state.title)
            .addRoute(
                screen: PageFourView.self,
                state: $viewModel.state.pageState,
                presentation: .fullscreen
            )
        }
    }
}
