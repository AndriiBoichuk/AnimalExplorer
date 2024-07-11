//
//  DependencyValues+Extension.swift
//  AnimalExplorer
//
//  Created by Andrii Boichuk on 11.07.2024.
//

import Foundation
import Dependencies

extension DependencyValues {
    var networkManager: any NetworkManagerProtocol {
        get { self[NetworkManagerKey.self] }
        set { self[NetworkManagerKey.self] = newValue }
    }
    var animalsNetworkService: any AnimalsNetworkServiceProtocol {
        get { self[AnimalsNetworkServiceKey.self] }
        set { self[AnimalsNetworkServiceKey.self] = newValue }
    }
}
