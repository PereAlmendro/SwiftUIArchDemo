//
//  LastPageView.swift
//  ArchDemo
//
//  Created by Pere Almendro on 17/3/25.
//

import Foundation
import SwiftUI

final class LastPageViewModel: ViewModel {
    // MARK: - Dependencies
    // MARK: - State
    struct State {
        // MARK: - Data
        let title: String = "Last Page"
        // MARK: - Navigations
        // MARK: - UI & Computed properties
    }
    @Published var state: State
    init(state: State) {
        self.state = state
    }

    // MARK: - Actions
    enum Action {
        case endFlow
    }
    func send(action: Action) {
        switch action {
        case .endFlow:
            break
        }
    }
}

struct LastPageView: ScreenView {
    typealias ViewM = LastPageViewModel
    @StateObject var viewModel: LastPageViewModel
    init(viewModel: LastPageViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    @EnvironmentObject var mainViewModel: MainViewModel

    var body: some View {
        VStack {
            Spacer()
            Text(viewModel.state.title)
            Button(action: {
                mainViewModel.send(action: .endFlow)
            }, label: {
                Text("FINISH FLOW")
            })
            Spacer()
        }
        .toolbar(viewModel.state.title)
    }
}
