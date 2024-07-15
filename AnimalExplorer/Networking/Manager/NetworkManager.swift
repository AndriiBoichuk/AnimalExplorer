//
//  NetworkManager.swift
//  AnimalExplorer
//
//  Created by Andrii Boichuk on 11.07.2024.
//

import Foundation
import Dependencies

protocol NetworkManagerProtocol {
    func fetchData<T: Decodable>(from url: URL) async throws -> T
}

struct NetworkManager: NetworkManagerProtocol {
    @Dependency(\.urlSession) var urlSession
    
    func fetchData<T: Decodable>(from url: URL) async throws -> T {
        let data = try await urlSession.data(from: url).0
        let jsonDecoder = JSONDecoder()
        
        return try jsonDecoder.decode(T.self, from: data)
    }
    
}

extension DependencyValues {
    enum NetworkManagerKey: DependencyKey {
        static let liveValue: any NetworkManagerProtocol = NetworkManager()
        static let previewValue: any NetworkManagerProtocol = NetworkManager()
    }
}
    
