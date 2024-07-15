//
//  DependencyValues+Extension.swift
//  AnimalExplorer
//
//  Created by Andrii Boichuk on 11.07.2024.
//

import Foundation
import Dependencies
import CoreDataLayer

extension DependencyValues {
    var networkManager: any NetworkManagerProtocol {
        get { self[NetworkManagerKey.self] }
        set { self[NetworkManagerKey.self] = newValue }
    }
    var animalsRepository: any AnimalsRepositoryProtocol {
        get { self[AnimalsRepositoryKey.self] }
        set { self[AnimalsRepositoryKey.self] = newValue }
    }
    
    var dbService: DBService {
        get { self[DBService.self] }
        set { self[DBService.self] = newValue }
    }
}

extension DBService: DependencyKey {
    public static var liveValue: DBService = DBService(modelName: "AnimalExplorer")
    public static var previewValue: DBService = DBService(modelName: "AnimalExplorer", inMemory: true)
    public static var testValue: DBService = DBService(modelName: "AnimalExplorer", inMemory: true)
}
