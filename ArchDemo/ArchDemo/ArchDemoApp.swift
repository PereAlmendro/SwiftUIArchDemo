//
//  ArchDemoApp.swift
//  ArchDemo
//
//  Created by Pere Almendro on 31/1/25.
//

import SwiftUI

@main
struct ArchDemoApp: App {
    @State var mainState: MainViewModel.State?
    @State var vibrationState: VibrationsViewModel.State?
    @State var retroListState: RetrospectivesListViewModel.State?
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrollView {
                    VStack(spacing: 24) {
                        Button {
                            retroListState = .init()
                        } label: {
                            Text("Start Retro")
                                .font(.headline)
                        }
#if DEBUG
                        Button {
                            mainState = .init()
                        } label: {
                            Text("Navigation flow sample")
                                .font(.headline)
                        }
                        Button {
                            vibrationState = .init()
                        } label: {
                            Text("System vibrations sample")
                                .font(.headline)
                        }
#endif
                    }
                    .frame(maxWidth: .infinity)
                }
                .toolbar("Features")
            }
            .addRoute(
                screen: MainView.self,
                state: $mainState,
                presentation: .fullscreen
            )
            .addRoute(
                screen: VibrationsView.self,
                state: $vibrationState,
                presentation: .fullscreen
            )
            .addRoute(
                screen: RetrospectivesListView.self,
                state: $retroListState,
                presentation: .fullscreen
            )
        }
    }
}
