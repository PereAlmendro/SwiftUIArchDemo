//
//  ArchDemoApp.swift
//  ArchDemo
//
//  Created by Pere Almendro on 31/1/25.
//

import SwiftUI

@main
struct ArchDemoApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = DevListViewModel(
                state: .init()
            )
            DevListView(viewModel: viewModel)
        }
    }
}
