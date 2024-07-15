//
//  RootView.swift
//  AnimalExplorer
//
//  Created by Andrii Boichuk on 12.07.2024.
//

import SwiftUI
import ComposableArchitecture

struct RootView: View {
    @Perception.Bindable var store: StoreOf<RootFeature>
    
    var body: some View {
        WithPerceptionTracking {
            NavigationStack {
                AnimalsListView(store: store.scope(state: \.animalsListState, action: \.animalsListAction))
            }
        }
    }
}
