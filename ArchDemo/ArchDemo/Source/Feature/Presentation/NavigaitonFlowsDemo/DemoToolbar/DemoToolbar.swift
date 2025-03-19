//
//  DemoToolbar.swift
//  ArchDemo
//
//  Created by Pere Almendro on 19/3/25.
//

import Foundation
import SwiftUI

extension View {
    func toolbar(_ title: String) -> some View {
        modifier(Toolbar(title: title))
    }
}

struct Toolbar: ViewModifier {
    let title: String
    var showBackButton: Bool = true

    @Environment(\.dismiss) private var dismiss

    func body(content: Content) -> some View {
        content
            .navigationTitle(title)
            .navigationBarBackButtonHidden()
            .toolbar {
                if showBackButton {
                    ToolbarItem(placement: .topBarLeading) {
                        Image(systemName: "arrow.left")
                            .onTapGesture {
                                dismiss()
                            }
                    }
                }
            }
    }
}
