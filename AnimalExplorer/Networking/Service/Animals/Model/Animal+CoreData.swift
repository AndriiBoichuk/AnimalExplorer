//
//  Animal+CoreData.swift
//  AnimalExplorer
//
//  Created by Andrii Boichuk on 12.07.2024.
//

import Foundation
import CoreDataLayer
import CoreData

// MARK: - FromDBConvetible

extension Animal: FromDBConvetible {
    init?(with object: CoreDataLayer.ManagedObject) {
        guard let animal = object as? AnimalEntity else {
            return nil
        }
        
        self.title = animal.title ?? ""
        self.description = animal.subtitle ?? ""
        self.image = .init(string: animal.imageUrl ?? "")
        self.order = Int(animal.order)
        self.status = .init(rawValue: animal.status ?? "")
        self.content = animal.animalContent?.compactMap { entity in
            if let animalContent = entity as? AnimalContentEntity {
                return .init(with: animalContent)
            } else {
                return nil
            }
        }
    }
}

extension Animal.FactInfo: FromDBConvetible {
    init?(with object: ManagedObject) {
        guard let animalFact = object as? AnimalContentEntity else {
            return nil
        }
        
        self.fact = animalFact.fact ?? ""
        self.image = .init(string: animalFact.imageUrl ?? "")
    }
}

// MARK:

extension Animal: ToDBConvetible {
    func object(in context: ManagedObjectContext) -> ManagedObject {
        let animal = AnimalEntity(context: context)
        
        animal.title = self.title
        animal.subtitle = self.description
        animal.imageUrl = self.image?.absoluteString
        animal.order = Int16(self.order)
        animal.status = self.status?.rawValue
        animal.animalContent = NSSet(array: self.content?.map { $0.object(in: context) } ?? [])
        
        return animal
    }
}

extension Animal.FactInfo: ToDBConvetible {
    func object(in context: ManagedObjectContext) -> ManagedObject {
        let animalContent = AnimalContentEntity(context: context)
        
        animalContent.fact = self.fact
        animalContent.imageUrl = self.image?.absoluteString
        
        return animalContent
    }
}
