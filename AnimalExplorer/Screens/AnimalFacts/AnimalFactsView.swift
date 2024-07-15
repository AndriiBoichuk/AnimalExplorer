//
//  AnimalFactsView.swift
//  AnimalExplorer
//
//  Created by Andrii Boichuk on 12.07.2024.
//

import SwiftUI
import ComposableArchitecture

struct AnimalFactsView: View {
    @Perception.Bindable var store: StoreOf<AnimalFactsFeature>
    
    var body: some View {
        WithPerceptionTracking {
            VStack {
                Spacer()
                TabView(
                    selection: $store.selectedFact.sending(\.selectFact)
                ) {
                    ForEach(
                        store.scope(state: \.facts, action: \.facts),
                        id: \.state.id
                    ) { factPageStore in
                        FactPageView(store: factPageStore,
                                     isNextDisabled: store.isNextPageDisabled,
                                     isPrevDisabled: store.isPrevPageDisabled)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                Spacer()
                Spacer()
            }
            .background {
                Color.aeMain
                    .ignoresSafeArea()
            }
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        store.send(.backButtonTapped)
                    } label: {
                        Image(.navBarBack)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: Constant.Height.backButton)
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text(store.animal.title)
                        .font(.aeLargeTitle)
                }
            }
        }
    }
}

// MARK: - Constants

extension AnimalFactsView {
    enum Constant {
        enum Padding {
            static let mainHorizontal: CGFloat = 20
        }
        
        enum Height {
            static let backButton: CGFloat = 16
        }
    }
}
