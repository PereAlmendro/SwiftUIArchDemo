//
//  PageFiveView.swift
//  ArchDemo
//
//  Created by Pere Almendro on 17/3/25.
//

import Foundation
import SwiftUI

final class PageFiveViewModel: ViewModel {
    // MARK: - Dependencies
    // MARK: - State
    struct State {
        // MARK: - Data
        let title: String = "Page five"
        // MARK: - Navigations
        var pageState: LastPageViewModel.State?
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

struct PageFiveView: ScreenView {
    typealias ViewM = PageFiveViewModel
    @StateObject var viewModel: PageFiveViewModel
    init(viewModel: PageFiveViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            Spacer()
            Text(viewModel.state.title)
            Button(action: {
                viewModel.send(action: .navigate)
            }, label: {
                Text("Navigate to last page")
            })
            Spacer()
        }
        .navigationTitle(viewModel.state.title)
        .addRoute(
            screen: LastPageView.self,
            state: $viewModel.state.pageState,
            presentation: .push
        )
    }
}
