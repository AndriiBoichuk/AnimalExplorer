//
//  AlertFeature.swift
//  AnimalExplorer
//
//  Created by Andrii Boichuk on 14.07.2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct AlertFeature {
    enum Action {
        case cancel
        case ok
        case watchAd
    }
}
