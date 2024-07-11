//
//  MockAnimalsService.swift
//  AnimalExplorer
//
//  Created by Andrii Boichuk on 11.07.2024.
//

import Foundation

class MockAnimalsService: AnimalsNetworkServiceProtocol {
    func fetchAnimalTypes() async throws -> Animals {
        try await Task.sleep(for: .milliseconds(500))
        return [.mock, .mock(with: 1), .mock(with: 3, status: .free), .mock(with: 4, status: .free)]
    }
}
