//
//  PageOneView.swift
//  ArchDemo
//
//  Created by Pere Almendro on 17/3/25.
//

import Foundation
import SwiftUI

final class PageOneViewModel: ViewModel {
    // MARK: - Dependencies
    // MARK: - State
    struct State {
        // MARK: - Data
        let title: String = "Page one"
        // MARK: - Navigations
        var pageState: PageTwoViewModel.State?
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

struct PageOneView: ScreenView {
    typealias ViewM = PageOneViewModel
    @StateObject var viewModel: PageOneViewModel
    init(viewModel: PageOneViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text(viewModel.state.title)
                Button(action: {
                    viewModel.send(action: .navigate)
                }, label: {
                    Text("Navigate to page 2")
                })
                Spacer()
            }
            .toolbar(viewModel.state.title)
            .addRoute(
                screen: PageTwoView.self,
                state: $viewModel.state.pageState,
                presentation: .push
            )
        }
    }
}
