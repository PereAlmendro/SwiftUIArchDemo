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
        case image(Image)
        case text(LocalizedStringKey)
        case custom(() -> any View)
    }

    let id: UUID = UUID()
    let type: ItemType
    var action: (() -> Void)?
}

extension View {
    func toolbar(
        _ title: String,
        leftItems: [NavigationItem] = [],
        rightItems: [NavigationItem] = []
    ) -> some View {
        modifier(ToolbarModifier(
            title: LocalizedStringKey(title),
            leftItems: leftItems,
            rightItems: rightItems
        ))
    }
}

struct ToolbarModifier: ViewModifier {
    let title: LocalizedStringKey
    let leftItems: [NavigationItem]
    let rightItems: [NavigationItem]

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
                    case .image(let image):
                        image
                    case .text(let text):
                        Text(text)
                            .font(.headline)
                    case .custom(let view):
                        AnyView(view())
                    }
                }
                .onTapGesture {
                    item.action?()
                }
            }
        }
    }
}
