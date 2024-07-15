//
//  FactPageFeature.swift
//  AnimalExplorer
//
//  Created by Andrii Boichuk on 15.07.2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct FactPageFeature {
    @ObservableState
    struct State: Equatable, Identifiable {
        let factInfo: Animal.FactInfo
        
        var id: Animal.FactInfo {
            factInfo
        }
    }
    
    enum Action {
        case nextPage
        case prevPage
    }
}
