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
        var showBottomSheet: Bool = false
        // MARK: - UI & Computed properties
    }
    @Published var state: State
    init(state: State) {
        self.state = state
    }

    // MARK: - Actions
    enum Action {
        case navigate
        case showBottomSheet
    }
    func send(action: Action) {
        switch action {
        case .navigate:
            state.pageState = .init()
        case .showBottomSheet:
            state.showBottomSheet = true
        }
    }
}

struct PageTwoView: ScreenView {
    typealias ViewM = PageTwoViewModel
    @StateObject var viewModel: PageTwoViewModel
    init(viewModel: PageTwoViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            Text(viewModel.state.title)
            Button(action: {
                viewModel.send(action: .navigate)
            }, label: {
                Text("Navigate to page 3")
            })
            Text("show bottom sheet")
                .onTapGesture {
                    viewModel.send(action: .showBottomSheet)
                }
            Spacer()
        }
        .toolbar(viewModel.state.title, leftItems: [
            .init(type: .back, action: {
                dismiss()
            })
        ])
        .addRoute(
            screen: PageThreeView.self,
            state: $viewModel.state.pageState,
            presentation: .push
        )
        .addRoute(
            isPresented: $viewModel.state.showBottomSheet,
            presentation: .sheet([ .medium ]),
            destination: {
                VStack(spacing: 40) {
                    Text("SOME INFO TITLE")
                        .font(.headline)
                    Text("lorem ipsum dolor sit amet ...")
                        .foregroundStyle(.gray)
                }
            }
        )
    }
}
