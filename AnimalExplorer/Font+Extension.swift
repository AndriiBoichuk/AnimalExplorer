//
//  Font+Extension.swift
//  AnimalExplorer
//
//  Created by Andrii Boichuk on 15.07.2024.
//

import SwiftUI

extension Font {
    static func basicRegular(size: CGFloat) -> Font {
        Font.custom("Basic-Regular", size: size)
    }
}

extension Font {
    static let aeLargeTitle: Font = {
        Font.basicRegular(size: 17)
    }()
    
    static let aeTitle: Font = {
        Font.basicRegular(size: 16)
    }()
    
    static let aeSubtitle: Font = {
        Font.basicRegular(size: 12)
    }()
    
    static let aeBody: Font = {
        Font.basicRegular(size: 18)
    }()
}
