//
//  Developers.swift
//  ArchDemo
//
//  Created by Pere Almendro on 31/1/25.
//

enum Platform: String {
    case iOS
    case android
    case dotNet
    case ninja
    case kasper
}

struct Developer: Identifiable {
    let id: String
    let name: String
    let platform: Platform
}
