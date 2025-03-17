//
//  DevListView.swift
//  ArchDemo
//
//  Created by Pere Almendro on 31/1/25.
//

import SwiftUI

struct DevListView: ScreenView {
    typealias ViewM = DevListViewModel
    @StateObject var viewModel: DevListViewModel
    init(viewModel: DevListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
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
            .addRoute(
                screen: DevDetailView.self,
                state: $viewModel.state.pushDetailState,
                presentation: .push
            )
            .addRoute(
                screen: DevDetailView.self,
                state: $viewModel.state.sheetDetailState,
                presentation: .sheet
            )
            .addRoute(
                screen: DevDetailView.self,
                state: $viewModel.state.fullScreenDetailState,
                presentation: .fullscreen
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
