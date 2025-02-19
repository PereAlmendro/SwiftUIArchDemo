//
//  ScreenView.swift
//  ArchDemo
//
//  Created by Pere Almendro on 19/2/25.
//

import SwiftUI

protocol ScreenView: View {
    associatedtype ViewM: ViewModel
    init(viewModel: ViewM)
}
