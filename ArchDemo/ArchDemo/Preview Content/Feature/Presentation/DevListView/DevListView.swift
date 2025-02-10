//
//  DevListView.swift
//  ArchDemo
//
//  Created by Pere Almendro on 31/1/25.
//

import SwiftUI

struct DevListView: View {
    @StateObject var viewModel: DevListViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                DevelopersList(
                    developers: $viewModel.state.developers,
                    onDeveloperTap: { developer in
                        viewModel.send(action: .onDeveloperTap(dev: developer))
                    }
                )

                Button(action: {
                    viewModel.send(action: .requestPushNavigation)
                }, label: {
                    Text("PUSH")
                })

                Button(action: {
                    viewModel.send(action: .requestSheetNavigation)
                }, label: {
                    Text("SHEET / PRESENT")
                })

                Button(action: {
                    viewModel.send(action: .requestFullScreenNavigation)
                }, label: {
                    Text("PRESENT FULL SCREEN")
                })

                Spacer()
            }
            .padding()
            .navigationTitle("Developers")
            // MARK: - Add routing
            .addDetailRoute(
                state: $viewModel.state.pushDetailState,
                pushNavigation: true
            )
            .addDetailRoute(
                state: $viewModel.state.sheetDetailState
            )
            .addDetailRoute(
                state: $viewModel.state.fullScreenDetailState,
                fullScreen: true
            )
        }
        .onAppear {
            viewModel.send(action: .loadData)
        }
    }
}

struct DevelopersList: View {
    @Binding var developers: [Developer]
    var onDeveloperTap: (Developer) -> Void

    var body: some View {
        VStack(spacing: .zero) {
            ForEach(developers) { developer in
                HStack {
                    Text(developer.name)
                    Spacer()
                    Image(systemName: "arrow.forward")
                }
                .background()
                .padding()
                .onTapGesture {
                    onDeveloperTap(developer)
                }
            }
        }
    }
}
