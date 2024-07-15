//
//  RootFeature.swift
//  AnimalExplorer
//
//  Created by Andrii Boichuk on 12.07.2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct RootFeature {
    @ObservableState
    struct State {
        var animalsListState = AnimalsListFeature.State()
    }
    
    enum Action {
        case animalsListAction(AnimalsListFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.animalsListState, action: \.animalsListAction) {
            AnimalsListFeature()
        }
    }
}

extension RootFeature {
    @Reducer
    enum Path {
        case animalFacts(AnimalFactsFeature)
    }
}
