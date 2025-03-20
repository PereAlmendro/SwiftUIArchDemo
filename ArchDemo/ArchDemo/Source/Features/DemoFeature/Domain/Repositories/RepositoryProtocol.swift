//
//  RepositoryProtocol.swift
//  ArchDemo
//
//  Created by Pere Almendro on 31/1/25.
//

protocol RepositoryProtocol: Sendable {
    func getDevelopers() async throws -> [Developer]
    func getDeveloperDetail(id: String) async throws -> DeveloperDetail
}
