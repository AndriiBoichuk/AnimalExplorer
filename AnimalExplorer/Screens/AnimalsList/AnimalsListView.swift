//
//  AnimalsListView.swift
//  AnimalExplorer
//
//  Created by Andrii Boichuk on 11.07.2024.
//

import SwiftUI

struct AnimalsListView: View {
    var body: some View {
        ScrollView {
            VStack {
                AnimalItemView(animal: .mock)
                AnimalItemView(animal: .mock)
                AnimalItemView(animal: .mock)
                AnimalItemView(animal: .mock)
            }
            .padding()
        }
        .background {
            Color.aeMain.ignoresSafeArea()
        }
    }
}

#Preview {
    AnimalsListView()
}
