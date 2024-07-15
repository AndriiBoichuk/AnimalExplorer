//
//  AnimalsListView.swift
//  AnimalExplorer
//
//  Created by Andrii Boichuk on 11.07.2024.
//

import SwiftUI
import ComposableArchitecture

struct AnimalsListView: View {
    @Perception.Bindable var store: StoreOf<AnimalsListFeature>
    
    var body: some View {
        WithPerceptionTracking {
            ScrollView {
                VStack {
                    if let animals = store.animals {
                        ForEach(animals) { animal in
                            Button {
                                store.send(.showAnimalFacts(animal, isAdWatched: false))
                            } label: {
                                AnimalItemView(animal: animal)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
            .overlay {
                if store.dataLoadingStatus == .loading {
                    ProgressView()
                        .frame(height: 150)
                }
            }
            .background {
                Color.aeMain.ignoresSafeArea()
            }
            .task {
                store.send(.loadCachedData)
            }
            .alert($store.scope(state: \.commingSoonAlert, action: \.commingSoonAlertAction))
            .alert($store.scope(state: \.adAlert, action: \.adAlertAction))
            .navigationDestination(item: $store.scope(
                state: \.animal,
                action: \.animalFactsAction
            )) { store in
                AnimalFactsView(store: store)
            }
        }
    }
}

#Preview {
    AnimalsListView(store: .init(
        initialState: AnimalsListFeature.State(),
        reducer: { AnimalsListFeature() }))
}
