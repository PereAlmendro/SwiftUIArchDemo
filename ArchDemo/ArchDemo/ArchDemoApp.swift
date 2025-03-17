//
//  ArchDemoApp.swift
//  ArchDemo
//
//  Created by Pere Almendro on 31/1/25.
//

import SwiftUI

@main
struct ArchDemoApp: App {
    @State var listState: DevListViewModel.State?
    @State var mainState: MainViewModel.State?
    @State var vibrationState: VibrationsViewModel.State?
    var body: some Scene {
        WindowGroup {
            NavigationView {
                VStack {
                    Spacer()
                    Text("LIST DETAIL DEMO")
                        .onTapGesture {
                            listState = .init()
                        }
                        .foregroundStyle(.blue)
                    Text("FLOW DEMO")
                        .onTapGesture {
                            mainState = .init()
                        }
                        .foregroundStyle(.blue)
                    Text("VIBRATIONS DEMO")
                        .onTapGesture {
                            vibrationState = .init()
                        }
                        .foregroundStyle(.blue)

                    Spacer()
                }


            }
            .addRoute(
                screen: DevListView.self,
                state: $listState,
                presentation: .fullscreen
            )
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
        }

    }
}
