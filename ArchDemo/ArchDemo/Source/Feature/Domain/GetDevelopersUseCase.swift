//
//  GetDataUseCase.swift
//  ArchDemo
//
//  Created by Pere Almendro on 31/1/25.
//
import Dependencies
import Foundation

struct GetDevelopersUseCase {

    typealias UseCase = () async throws -> [Developer]

    @Dependency(\.repository) var repository

    func execute() async throws -> [Developer] {
        Thread.printCurrent(label: "USECASE")
        return try await repository.getDevelopers()
    }
}

// MARK: - Add dependency to the Dependency manager

extension GetDevelopersUseCase: DependencyKey {
    static var liveValue: GetDevelopersUseCase.UseCase =
    GetDevelopersUseCase().execute
}

extension DependencyValues {
    var getDevelopers: GetDevelopersUseCase.UseCase {
        get { self[GetDevelopersUseCase.self] }
        set { self[GetDevelopersUseCase.self] = newValue }
    }
}
