//
//  AnimalsRepository.swift
//  AnimalExplorer
//
//  Created by Andrii Boichuk on 11.07.2024.
//

import Foundation
import Dependencies
import CoreDataLayer

protocol AnimalsRepositoryProtocol {
    func fetchAnimalsFromDB() async throws -> Animals
    func fetchAnimalsFromNetwork() async throws -> Animals
}

final class AnimalsRepository {
    @Dependency(\.networkManager) var networkManager
    @Dependency(\.dbService) var dbService
    
    private var url: URL?
    
    init() {
        self.url = URL(string: "https://raw.githubusercontent.com/AppSci/promova-test-task-iOS/main/animals.json")
    }
}

extension AnimalsRepository: AnimalsRepositoryProtocol {
    func fetchAnimalsFromDB() async throws -> Animals {
        let fetchRequest = FetchRequest<AnimalEntity>()
        return try await dbService.executeConvetible(fetchRequest: fetchRequest)
    }
    
    func fetchAnimalsFromNetwork() async throws -> Animals {
        guard let url else { throw NetworkError.invalidURL }
        let animals: Animals = try await networkManager.fetchData(from: url)
        saveToDB(animals: animals)
        return animals
    }
}

private extension AnimalsRepository {
    func saveToDB(animals: Animals) {
        
        Task.detached { [weak self] in
            var fetchRequest = FetchRequest<AnimalEntity>()
            for animal in animals {
                fetchRequest.predicate = nil
                fetchRequest = fetchRequest.filtered(\.title == animal.title)
                if let count = try await self?.dbService.count(fetchRequest: fetchRequest), count == 0 {
                    try? await self?.dbService.insert(model: animal)
                }
            }
        }
    }
}

extension DependencyValues {
    enum AnimalsRepositoryKey: DependencyKey {
        static let liveValue: any AnimalsRepositoryProtocol = AnimalsRepository()
        static let previewValue: any AnimalsRepositoryProtocol = MockAnimalsService()
    }
}

extension AnimalsRepository {
    enum NetworkError: Error {
        case invalidURL
    }
}
