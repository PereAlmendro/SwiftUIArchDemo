//
//  PageFourView.swift
//  ArchDemo
//
//  Created by Pere Almendro on 17/3/25.
//

import Foundation
import SwiftUI

final class PageFourViewModel: ViewModel {
    // MARK: - Dependencies
    // MARK: - State
    struct State {
        // MARK: - Data
        let title: String = "Page Four"
        // MARK: - Navigations
        var pageState: PageFiveViewModel.State?
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

struct PageFourView: ScreenView {
    typealias ViewM = PageFourViewModel
    @StateObject var viewModel: PageFourViewModel
    init(viewModel: PageFourViewModel) {
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
                    Text("Navigate to page 5")
                })
                Spacer()
            }
            .navigationTitle(viewModel.state.title)
            .addRoute(
                screen: PageFiveView.self,
                state: $viewModel.state.pageState,
                presentation: .push
            )
        }
    }
}
