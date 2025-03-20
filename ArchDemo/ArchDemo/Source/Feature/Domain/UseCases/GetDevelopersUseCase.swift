//
//  GetDataUseCase.swift
//  ArchDemo
//
//  Created by Pere Almendro on 31/1/25.
//
import Dependencies
import Foundation

struct GetDevelopersUseCase {

    @Dependency(\.repository) private var repository

    func execute() async throws -> [Developer] {
        Thread.printCurrent(label: "USECASE")
        return try await repository.getDevelopers()
    }
}

// MARK: - Add dependency to the Dependency manager

extension GetDevelopersUseCase: DependencyKey {
    static let liveValue: GetDevelopersUseCase =
    GetDevelopersUseCase()
}

extension DependencyValues {
    var getDevelopers: GetDevelopersUseCase {
        get { self[GetDevelopersUseCase.self] }
        set { self[GetDevelopersUseCase.self] = newValue }
    }
}
