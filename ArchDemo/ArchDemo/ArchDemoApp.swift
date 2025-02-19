//
//  ArchDemoApp.swift
//  ArchDemo
//
//  Created by Pere Almendro on 31/1/25.
//

import SwiftUI

@main
struct ArchDemoApp: App {
    @State var listState: DevListViewModel.State? = DevListViewModel.State()
    var body: some Scene {
        WindowGroup {
            Text("SPLASH SCREEN")
                .addRoute(
                    screen: DevListView.self,
                    state: $listState,
                    presentation: .fullscreen
                )
        }

    }
}
