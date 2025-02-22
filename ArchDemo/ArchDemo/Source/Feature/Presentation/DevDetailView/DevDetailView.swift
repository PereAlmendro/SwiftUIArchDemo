//
//  DevDetailView.swift
//  ArchDemo
//
//  Created by Pere Almendro on 31/1/25.
//

import SwiftUI

struct DevDetailView: ScreenView {
    typealias ViewM = DevDetailViewModel
    @StateObject var viewModel: DevDetailViewModel
    init(viewModel: DevDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            if !viewModel.state.loading,
               let detail = viewModel.state.devDetail {
                VStack(alignment: .leading) {
                    HStack {
                        Text("AGE:").font(.headline)
                        Text("\(detail.age)")
                        Spacer()
                    }
                    HStack {
                        Text("PLATFORM:").font(.headline)
                        Text("\(detail.platform.rawValue)")
                        Spacer()
                    }
                    HStack {
                        Text("EXP:").font(.headline)
                        Text("\(detail.experience)")
                        Spacer()
                    }
                    HStack {
                        Text("DISC COLOR:").font(.headline)
                        Text("\(detail.discColor)")
                        Spacer()
                    }
                    Button(
                        action: { dismiss() },
                        label: { Text("DISMISS") }
                    )
                    Spacer()


                }
                .frame(maxWidth: .infinity)
                .padding()
                .navigationTitle(detail.name)
            } else {
                Text("Loading...")
                    .onAppear {
                        viewModel.send(action: .loadData)
                    }
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar(content: {
            ToolbarItem(
                placement: .topBarLeading,
                content: {
                    Text("Go back")
                        .foregroundStyle(Color.primary)
                        .onTapGesture { dismiss() }
                })
        })
    }
}
