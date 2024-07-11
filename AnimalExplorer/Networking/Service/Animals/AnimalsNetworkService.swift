//
//  AnimalsNetworkService.swift
//  AnimalExplorer
//
//  Created by Andrii Boichuk on 11.07.2024.
//

import Foundation
import Dependencies

protocol AnimalsNetworkServiceProtocol {
    func fetchAnimalTypes() async throws -> Animals
}

final class AnimalsNetworkService {
    @Dependency(\.networkManager) var networkManager
    
    private var url: URL?
    
    init() {
        self.url = URL(string: "https://raw.githubusercontent.com/AppSci/promova-test-task-iOS/main/animals.json")
    }
}

extension AnimalsNetworkService: AnimalsNetworkServiceProtocol {
    func fetchAnimalTypes() async throws -> Animals {
        guard let url else { throw NetworkError.invalidURL }
        return try await networkManager.fetchData(from: url)
    }
}

extension DependencyValues {
    enum AnimalsNetworkServiceKey: DependencyKey {
        static let liveValue: any AnimalsNetworkServiceProtocol = AnimalsNetworkService()
        static let previewValue: any AnimalsNetworkServiceProtocol = MockAnimalsService()
    }
}

extension AnimalsNetworkService {
    enum NetworkError: Error {
        case invalidURL
    }
}
