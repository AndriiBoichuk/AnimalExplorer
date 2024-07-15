//
//  Collection+Extension.swift
//  AnimalExplorer
//
//  Created by Andrii Boichuk on 13.07.2024.
//

import Foundation

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
