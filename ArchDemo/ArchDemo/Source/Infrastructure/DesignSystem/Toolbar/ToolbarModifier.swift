//
//  ToolbarModifier.swift
//  ArchDemo
//
//  Created by Pere Almendro on 19/3/25.
//

import Foundation
import SwiftUI

struct NavigationItem: Identifiable {
    enum ItemType {
        case back
        case close
        case custom(Image)
        case text(String)
    }

    let id: UUID = UUID()
    let type: ItemType
    let action: () -> Void
}

extension View {
    func toolbar(
        _ title: String,
        leftItems: [NavigationItem] = [],
        rightItems: [NavigationItem] = []
    ) -> some View {
        modifier(ToolbarModifier(
            title: title,
            leftItems: leftItems,
            rightItems: rightItems
        ))
    }
}

struct ToolbarModifier: ViewModifier {
    let title: String
    let leftItems: [NavigationItem]
    let rightItems: [NavigationItem]

    @Environment(\.dismiss) private var dismiss

    func body(content: Content) -> some View {
        content
            .navigationTitle(title)
            .navigationBarBackButtonHidden()
            .toolbar {
                if !leftItems.isEmpty {
                    ToolbarItem(placement: .topBarLeading) {
                        NavigationItems(items: leftItems)
                    }
                }
                if !rightItems.isEmpty {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationItems(items: rightItems)
                    }
                }
            }
    }
}

struct NavigationItems: View {
    let items: [NavigationItem]

    var body: some View {
        HStack {
            ForEach(items) { item in
                Group {
                    switch item.type {
                    case .back:
                        Image(systemName: "chevron.left")
                    case .close:
                        Image(systemName: "xmark")
                    case .custom(let image):
                        image
                    case .text(let text):
                        Text(text)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    item.action()
                }
            }
        }
    }
}
