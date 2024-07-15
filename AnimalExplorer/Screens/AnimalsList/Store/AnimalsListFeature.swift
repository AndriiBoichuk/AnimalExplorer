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
    struct State {
        var animals: Animals?
        var dataLoadingStatus: DataLoadingStatus = .notStarted
        
        var commingSoonAlert: AlertState<AlertFeature.Action>?
        var adAlert: AlertState<AlertFeature.Action>?
        
        @Presents
        var animal: AnimalFactsFeature.State?
        
        fileprivate var selectedAnimal: Animal?
        
        fileprivate var shouldLoadData: Bool {
            !(dataLoadingStatus == .success || dataLoadingStatus == .loading)
        }
    }
    
    enum Action {
        case loadCachedData
        case loadNetworkData
        case loadedAnimals(Animals)
        case noAnimals
        
        case showNullContentAlert
        case showAdAlert
        case showAnimalFacts(Animal, isAdWatched: Bool)
        case watchAdd
        
        case commingSoonAlertAction(PresentationAction<AlertFeature.Action>)
        case adAlertAction(PresentationAction<AlertFeature.Action>)
        case animalFactsAction(PresentationAction<AnimalFactsFeature.Action>)
        
    }
    
    @Dependency(\.animalsRepository) var animalsRepository
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .loadCachedData:
                guard state.shouldLoadData else {
                    return .none
                }
                state.dataLoadingStatus = .loading
                return .run { send in
                    let animals = try await animalsRepository.fetchAnimalsFromDB()
                    await send(.loadedAnimals(animals))
                    await send(.loadNetworkData)
                }
            case .loadNetworkData:
                return .run { send in
                    let animals = try await animalsRepository.fetchAnimalsFromNetwork()
                    await send(.loadedAnimals(animals))
                }
            case .loadedAnimals(let animals):
                state.animals = sorted(animals: animals)
                state.dataLoadingStatus = .success
                return .none
            case .noAnimals:
                state.dataLoadingStatus = .error
                return .none
            case .showAnimalFacts(let animal, let isAdWatched):
                if isAdWatched {
                    state.dataLoadingStatus = .success
                }
                if animal.isContentEmpty {
                    return .send(.showNullContentAlert)
                } else if animal.status == .paid && !isAdWatched{
                    state.selectedAnimal = animal
                    return .send(.showAdAlert)
                }
                state.animal = AnimalFactsFeature.State(animal: animal)
                return .none
            case .showNullContentAlert:
                state.commingSoonAlert = commingSoonAlert
                return .none
            case .showAdAlert:
                state.adAlert = adAlert
                return .none
            case .commingSoonAlertAction:
                state.commingSoonAlert = nil
                return .none
            case .adAlertAction(let action):
                switch action {
                case .dismiss:
                    state.adAlert = nil
                case .presented(let alertAction):
                    switch alertAction {
                    case .cancel:
                        state.adAlert = nil
                    case .watchAd:
                        return .send(.watchAdd)
                    default:
                        break
                    }
                }
                return .none
            case .watchAdd:
                state.dataLoadingStatus = .loading
                return .run { [state] send in
                    try await Task.sleep(for: .seconds(2))
                    if let selectedAnimal = state.selectedAnimal {
                        await send(.showAnimalFacts(selectedAnimal, isAdWatched: true))
                    }
                }
            default:
                return .none
            }
        }
        .ifLet(\.$animal, action: \.animalFactsAction) {
            AnimalFactsFeature()
        }
    }
}

private extension AnimalsListFeature {
    var commingSoonAlert: AlertState<AlertFeature.Action> {
        AlertState(title: { TextState("No content") }) {
            ButtonState(action: .ok, label: { TextState("Ok") })
        }
    }
    
    var adAlert: AlertState<AlertFeature.Action> {
        AlertState(title: { TextState("Watch Ad to continue") }) {
            ButtonState(action: .cancel, label: { TextState("Cancel") })
            ButtonState(action: .watchAd, label: { TextState("Show Ad") })
        }
    }
    
    func sorted(animals: Animals) -> Animals {
        animals.sorted(by: { $0.order > $1.order })
    }
}
