//
//  DependenciesLib.swift
//  ArchDemo
//
//  Created by Pere Almendro on 1/2/25.
//

import Foundation
import Dependencies

/// Oficial docs -> https://swiftpackageindex.com/pointfreeco/swift-dependencies/main/documentation/dependencies

struct SampleRepo {
    func fetchSample() async -> Int { 20 }
}

/// The DependencyKey protocol implementation.
/// Provides the dependency Default implementation
/// liveValue: Is the default implementation and is mandatory to implement it
/// testValue: it is not needed for testing its optional and theres no need to implement it ( I dont like having testValue in prod code )
/// previewValue: Value used in previews, also optional
extension SampleRepo: DependencyKey {
    static var liveValue: SampleRepo = SampleRepo()
//    static var testValue: SampleRepo = SampleRepo()
//    static var previewValue: SampleRepo = SampleRepo()
}

/// The DependencyValues this object is the dependency container
/// Here we register the dependencies in the dependency container
/// This container is powered by swift @TaskLocal.
extension DependencyValues {
    var sampleRepo: SampleRepo {
        get { self[SampleRepo.self] }
        set { self[SampleRepo.self] = newValue }
    }
}

struct SampleUseCase {
    /// The @Dependency macro reads the specified dependency from the container (DependencyValues)
    /// powered by swift KeyPaths
    @Dependency(\.sampleRepo) var sampleRepo
    func execute() async -> Int {
        await sampleRepo.fetchSample()
    }
}

/// How to test mocking dependencies
struct TestCase {
    func test1() {
        // Use withDependencies to perfom an operation within the given overriten dependencies
        let sut = withDependencies { values in
            // override the dependency in the given DependencyValues to set the mock/test value of this dependency
            values[SampleRepo.self] = SampleRepo()
        } operation: {
            SampleUseCase()
        }
        // now sut has the mocked repository
    }
}

/// To understand how it works under the hood, we first need to understand swift KeyPaths and TaskLocals :
/// KeyPaths: https://docs.swift.org/swift-book/documentation/the-swift-programming-language/expressions#Key-Path-Expression
/// TaskLocals: https://developer.apple.com/documentation/swift/tasklocal
