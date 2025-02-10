//
//  Repository.swift
//  ArchDemo
//
//  Created by Pere Almendro on 31/1/25.
//
import Dependencies
import Foundation


struct Repository: RepositoryProtocol {

    func getDevelopers() async throws -> [Developer] {
        Thread.printCurrent(label: "REPOSITORY")
        return developers
    }

    func getDeveloperDetail(id: String) async throws -> DeveloperDetail {
        guard let dev = developers.first(where: { $0.id == id }) else {
            throw URLError(.badServerResponse)
        }
        return .init(
            id: dev.id,
            name: dev.name,
            platform: dev.platform,
            age: 32,
            experience: 8,
            discColor: "Green"
        )
    }

    // MARK: - Mock

    private var developers: [Developer] = [
        .init(
            id: "1",
            name: "Joan",
            platform: .android
        ),
        .init(
            id: "2",
            name: "Pere",
            platform: .iOS
        ),
        .init(
            id: "3",
            name: "Alex",
            platform: .dotNet
        ),
        .init(
            id: "4",
            name: "Jackie Chan",
            platform: .ninja
        ),
        .init(
            id: "5",
            name: "Kasper",
            platform: .kasper
        )
    ]
}

// MARK: - Add dependency to the Dependency manager

extension Repository: DependencyKey {
    static var liveValue: RepositoryProtocol = Repository()
}

extension DependencyValues {
    var repository: RepositoryProtocol {
        get { self[Repository.self] }
        set { self[Repository.self] = newValue }
    }
}
