//
//  ViewModel.swift
//  ArchDemo
//
//  Created by Pere Almendro on 31/1/25.
//

import SwiftUI

@MainActor
protocol ViewModel: ObservableObject {
    associatedtype State: Sendable
    associatedtype Action

    var state: State { get }
    init(state: State)

    func send(action: Action)
}
