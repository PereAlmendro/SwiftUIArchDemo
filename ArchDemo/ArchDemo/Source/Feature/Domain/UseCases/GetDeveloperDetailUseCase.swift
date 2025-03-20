//
//  GetDeveloperDetailUseCase.swift
//  ArchDemo
//
//  Created by Pere Almendro on 31/1/25.
//

import Foundation
import Dependencies

struct GetDeveloperDetailUseCase {

    @Dependency(\.repository) var repository

    func execute(id: String) async throws -> DeveloperDetail {
        try await repository.getDeveloperDetail(id: id)
    }
}

// MARK: - Add dependency to the Dependency manager

extension GetDeveloperDetailUseCase: DependencyKey {
    static let liveValue: GetDeveloperDetailUseCase =
    GetDeveloperDetailUseCase()
}

extension DependencyValues {
    var getDeveloperDetail: GetDeveloperDetailUseCase {
        get { self[GetDeveloperDetailUseCase.self] }
        set { self[GetDeveloperDetailUseCase.self] = newValue }
    }
}
