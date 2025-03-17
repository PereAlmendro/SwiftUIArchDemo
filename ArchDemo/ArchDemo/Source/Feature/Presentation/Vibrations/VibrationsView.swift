//
//  Vibrationsview.swift
//  ArchDemo
//
//  Created by Pere Almendro on 17/3/25.
//

import Foundation
import SwiftUI

final class VibrationsViewModel: ViewModel {
    // MARK: - Dependencies
    // MARK: - State
    struct State {
        // MARK: - Data
        // MARK: - Navigations
        // MARK: - UI & Computed properties
    }
    @Published var state: State
    init(state: State) {
        self.state = state
    }

    // MARK: - Actions
    enum Action {
        case vibrate(Vibration)
    }
    func send(action: Action) {
        switch action {
        case .vibrate(let vibration):
            vibration.vibrate()
        }
    }
}

struct VibrationsView: ScreenView {
    typealias ViewM = VibrationsViewModel
    @StateObject var viewModel: VibrationsViewModel
    init(viewModel: VibrationsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ScrollView {
            VStack {
                Text("error")
                    .padding(16)
                    .foregroundStyle(.blue)
                    .onTapGesture {
                        viewModel.send(action: .vibrate(.error))
                    }

                Text("success")
                    .padding(16)
                    .foregroundStyle(.blue)
                    .onTapGesture {
                        viewModel.send(action: .vibrate(.success))
                    }

                Text("warning")
                    .padding(16)
                    .foregroundStyle(.blue)
                    .onTapGesture {
                        viewModel.send(action: .vibrate(.warning))
                    }

                Text("light")
                    .padding(16)
                    .foregroundStyle(.blue)
                    .onTapGesture {
                        viewModel.send(action: .vibrate(.light))
                    }

                Text("medium")
                    .padding(16)
                    .foregroundStyle(.blue)
                    .onTapGesture {
                        viewModel.send(action: .vibrate(.medium))
                    }

                Text("heavy")
                    .padding(16)
                    .foregroundStyle(.blue)
                    .onTapGesture {
                        viewModel.send(action: .vibrate(.heavy))
                    }

                Text("soft")
                    .padding(16)
                    .foregroundStyle(.blue)
                    .onTapGesture {
                        viewModel.send(action: .vibrate(.soft))
                    }

                Text("rigid")
                    .padding(16)
                    .foregroundStyle(.blue)
                    .onTapGesture {
                        viewModel.send(action: .vibrate(.rigid))
                    }

                Text("selection")
                    .padding(16)
                    .foregroundStyle(.blue)
                    .onTapGesture {
                        viewModel.send(action: .vibrate(.selection))
                    }

                Text("oldSchool")
                    .padding(16)
                    .foregroundStyle(.blue)
                    .onTapGesture {
                        viewModel.send(action: .vibrate(.oldSchool))
                    }
            }
        }
    }
}

import AudioToolbox

enum Vibration {
    case error
    case success
    case warning
    case light
    case medium
    case heavy
    case soft
    case rigid
    case selection
    case oldSchool

    @MainActor
    public func vibrate() {
        switch self {
        case .error:
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        case .success:
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        case .warning:
            UINotificationFeedbackGenerator().notificationOccurred(.warning)
        case .light:
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        case .medium:
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        case .heavy:
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        case .soft:
            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
        case .rigid:
            UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
        case .selection:
            UISelectionFeedbackGenerator().selectionChanged()
        case .oldSchool:
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
    }
}
