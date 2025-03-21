//
//  TimerTimePicker.swift
//  ArchDemo
//
//  Created by Pere Almendro on 21/3/25.
//

import Foundation
import SwiftUI

struct TimerTimePicker: View {
    @Binding var minutes: Int
    @Binding var seconds: Int
    var onTimeSelected: () -> Void

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Spacer()
                Button(LocalizedStringKey("done")) {
                    onTimeSelected()
                    dismiss()
                }
            }

            HStack {
                VStack {
                    Text(LocalizedStringKey("minutes"))
                        .font(.headline)
                    Picker(UUID().uuidString, selection: $minutes) {
                        ForEach(0 ..< 60 ) { index in
                            Text("\(index)").tag(index)
                        }
                    }
                    .pickerStyle(.wheel)
                }
                VStack {
                    Text(LocalizedStringKey("seconds"))
                        .font(.headline)
                    Picker(UUID().uuidString, selection: $seconds) {
                        ForEach(0 ..< 60 ) { index in
                            Text("\(index)").tag(index)
                        }
                    }
                    .pickerStyle(.wheel)
                }
            }
            Spacer()
        }
        .padding()
    }
}
