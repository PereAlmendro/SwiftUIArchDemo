//
//  PageTwoView.swift
//  ArchDemo
//
//  Created by Pere Almendro on 17/3/25.
//

import Foundation
import SwiftUI

final class PageTwoViewModel: ViewModel {
    // MARK: - Dependencies
    // MARK: - State
    struct State {
        // MARK: - Data
        let title: String = "Page two"
        // MARK: - Navigations
        var pageState: PageThreeViewModel.State?
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

struct PageTwoView: ScreenView {
    typealias ViewM = PageTwoViewModel
    @StateObject var viewModel: PageTwoViewModel
    init(viewModel: PageTwoViewModel) {
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
                    Text("Navigate to page 3")
                })
                Spacer()
            }
            .navigationTitle(viewModel.state.title)
            .addRoute(
                screen: PageThreeView.self,
                state: $viewModel.state.pageState,
                presentation: .push
            )
        }
    }
}
