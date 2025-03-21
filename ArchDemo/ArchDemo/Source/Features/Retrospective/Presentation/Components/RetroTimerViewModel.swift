//
//  RetroTimerViewModel.swift
//  ArchDemo
//
//  Created by Pere Almendro on 21/3/25.
//

import Combine
import Foundation
import UserNotifications
import AudioToolbox

let kSystemSoundID_CalendarAlert: SystemSoundID = 1005

final class RetroTimerViewModel: ViewModel {

    struct State: Sendable {
        // MARK: - Navigations
        var isConfigPresented: Bool = false

        // MARK: - UI & Computed properties
        var initialDuration: TimeInterval = 5 * 60
        var currentDuration: TimeInterval = 5 * 60
        var countDownValue: TimeInterval = 5 * 60
        var countDownText: String = ""
        var isRunning: Bool = false
        var minutes: Int = 10
        var seconds: Int = 0
    }
    @Published var state: State
    init(state: State = .init()) {
        self.state = state
    }

    private var cancellables: [AnyCancellable] = []

    enum Action {
        case onAppear
        case onTimeUpdated
        case onEditTimeRequested
        case onStartTimerRequested
        case onStopTimerRequested
        case onPauseTimerRequested
    }
    func send(action: Action) {
        switch action {
        case .onAppear:
            var newState = state
            newState.countDownText = format(
                state.initialDuration, using: [.minute, .second]
            )
            state = newState

        case .onEditTimeRequested:
            send(action: .onStopTimerRequested)
            state.isConfigPresented.toggle()

        case .onStartTimerRequested:
            guard !state.isRunning else {
                return
            }

            let startTime = Date()
            Timer
                .publish(every: 0.1, on: .main, in: .common)
                .autoconnect()
                .sink { [weak self] _ in
                    guard let self else { return }
                    let interval = Date().timeIntervalSince(startTime)
                    self.state.countDownValue = self.state.currentDuration - interval
                    self.state.countDownText = format(
                        self.state.countDownValue, using: [.minute, .second]
                    )
                    if self.state.countDownValue <= 0 {
                        self.fireAlarm()
                        self.cancellables.removeAll()
                        self.state.isRunning = false
                    }
                }
                .store(in: &cancellables)
            state.isRunning = true

        case .onStopTimerRequested:
            cancellables.removeAll()

            var newState = state
            newState.countDownText = format(
                state.initialDuration, using: [.minute, .second]
            )
            newState.currentDuration = state.initialDuration
            newState.isRunning = false
            state = newState

        case .onPauseTimerRequested:
            cancellables.removeAll()

            var newState = state
            newState.currentDuration = state.countDownValue
            newState.isRunning = false
            state = newState

        case .onTimeUpdated:
            let newTime = Double((state.minutes * 60) + state.seconds)

            var newState = state
            newState.countDownText = format(
                newTime, using: [.minute, .second]
            )
            newState.initialDuration = newTime
            newState.currentDuration = newTime
            newState.isRunning = false
            state = newState
        }
    }
}

private extension RetroTimerViewModel {
    func format(
        _ interval: TimeInterval,
        using units: NSCalendar.Unit
    ) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = units
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: interval) ?? "0"
    }

    func fireAlarm() {
        AudioServicesPlaySystemSound(
            kSystemSoundID_CalendarAlert
        )
    }
}
