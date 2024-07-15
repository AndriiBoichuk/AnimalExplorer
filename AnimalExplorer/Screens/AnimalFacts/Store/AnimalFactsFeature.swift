//
//  AnimalFactsFeature.swift
//  AnimalExplorer
//
//  Created by Andrii Boichuk on 12.07.2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct AnimalFactsFeature {
    @ObservableState
    struct State {
        var animal: Animal
        var selectedFact: Animal.FactInfo
        
        var facts: IdentifiedArrayOf<FactPageFeature.State>
        
        var isNextPageDisabled: Bool {
            (facts.index(id: selectedFact) ?? facts.count) + 1 >= facts.endIndex
        }
        
        var isPrevPageDisabled: Bool {
            facts.index(id: selectedFact) ?? 0 == 0
        }
        
        init(animal: Animal) {
            self.animal = animal
            self.facts = .init(uniqueElements:  animal.content?.map {
                FactPageFeature.State(factInfo: $0)
            } ?? [])
            
            self.selectedFact = animal.content?.first ?? .mock
        }
    }
    
    enum Action {
        case backButtonTapped
        case selectFact(Animal.FactInfo)
        case facts(IdentifiedActionOf<FactPageFeature>)
    }
    
    @Dependency(\.dismiss) private var dismiss
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .backButtonTapped:
                return .run { send in
                    await dismiss()
                }
            case .facts(.element(id: _, action: .nextPage)):
                if let index = indexOfFact(from: state), index + 1 < state.facts.count {
                    state.selectedFact = state.facts[index + 1].factInfo
                }
                return .none
            case .facts(.element(id: _, action: .prevPage)):
                if let index = indexOfFact(from: state), index > 0 {
                    state.selectedFact = state.facts[index - 1].factInfo
                }
                return .none
            case .selectFact(let factInfo):
                if factInfo != state.selectedFact {
                    state.selectedFact = factInfo
                }
                return .none
            }
        }
        .forEach(\.facts, action: \.facts) {
            FactPageFeature()
        }
    }
}

private extension AnimalFactsFeature {
    func indexOfFact(from state: AnimalFactsFeature.State) -> Int? {
        return state.facts.index(id: state.selectedFact)
    }
}
