//
//  RetroTimerView.swift
//  ArchDemo
//
//  Created by Pere Almendro on 21/3/25.
//

import Foundation
import SwiftUI

struct RetroTimerView: View {
    @StateObject var viewModel: RetroTimerViewModel = .init()

    private let iconSize: CGFloat = 24

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "play.circle")
                .resizable()
                .frame(width: iconSize, height: iconSize)
                .onTapGesture {
                    viewModel.send(action: .onStartTimerRequested)
                }

            Image(systemName: "stop.circle")
                .resizable()
                .frame(width: iconSize, height: iconSize)
                .onTapGesture {
                    viewModel.send(action: .onStopTimerRequested)
                }

            Text(viewModel.state.countDownText)
                .font(.title3.bold())

            Image(systemName: "pause.circle")
                .resizable()
                .frame(width: iconSize, height: iconSize)
                .onTapGesture {
                    viewModel.send(action: .onPauseTimerRequested)
                }

            Image(systemName: "pencil")
                .resizable()
                .frame(width: 20, height: 20)
                .onTapGesture {
                    viewModel.send(action: .onEditTimeRequested)
                }
        }
        .task {
            viewModel.send(action: .onAppear)
        }
        .addRoute(
            isPresented: $viewModel.state.isConfigPresented,
            presentation: .sheet([.fraction(0.35)]),
            destination: {
                TimerTimePicker(
                    minutes: $viewModel.state.minutes,
                    seconds: $viewModel.state.seconds
                ) {
                    viewModel.send(action: .onTimeUpdated)
                }
            }
        )
    }
}
