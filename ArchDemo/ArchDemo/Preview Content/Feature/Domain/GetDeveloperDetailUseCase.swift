//
//  GetDeveloperDetailUseCase.swift
//  ArchDemo
//
//  Created by Pere Almendro on 31/1/25.
//

import Foundation
import Dependencies

struct GetDeveloperDetailUseCase {

    typealias UseCase = (
        _ id: String
    ) async throws -> DeveloperDetail

    @Dependency(\.repository) var repository

    func execute(id: String) async throws -> DeveloperDetail {
        try await repository.getDeveloperDetail(id: id)
    }
}

// MARK: - Add dependency to the Dependency manager

extension GetDeveloperDetailUseCase: DependencyKey {
    static var liveValue: GetDeveloperDetailUseCase.UseCase =
    GetDeveloperDetailUseCase().execute(id:)
}

extension DependencyValues {
    var getDeveloperDetail: GetDeveloperDetailUseCase.UseCase {
        get { self[GetDeveloperDetailUseCase.self] }
        set { self[GetDeveloperDetailUseCase.self] = newValue }
    }
}
