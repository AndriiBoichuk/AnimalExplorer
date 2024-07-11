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
                            AnimalItemView(animal: animal)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
            .background {
                Color.aeMain.ignoresSafeArea()
            }
            .task {
                await store.send(.loadData).finish()
            }
        }
    }
}

#Preview {
    AnimalsListView(store: .init(
        initialState: AnimalsListFeature.State(),
        reducer: { AnimalsListFeature() }))
}
