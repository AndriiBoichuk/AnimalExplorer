//
//  AnimalsListFeature.swift
//  AnimalExplorer
//
//  Created by Andrii Boichuk on 11.07.2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct AnimalsListFeature {
    @ObservableState
    struct State: Equatable {
        var isLoading: Bool = false
        var animals: Animals?
    }
    
    enum Action {
        case loadData
        case loadedAnimals(Animals)
        case noAnimals
    }
    
    @Dependency(\.animalsNetworkService) var animalsNetworkService
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .loadData:
                state.isLoading = true
                return .run { send in
                    let animals = try await animalsNetworkService.fetchAnimalTypes()
                    await send(.loadedAnimals(animals))
                }
            case .loadedAnimals(let animals):
                state.animals = animals
                state.isLoading = false
                return .none
            case .noAnimals:
                state.isLoading = false
                return .none
            }
        }
    }
}
