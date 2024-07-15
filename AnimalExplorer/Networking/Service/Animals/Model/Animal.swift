//
//  Animal.swift
//  AnimalExplorer
//
//  Created by Andrii Boichuk on 11.07.2024.
//

import Foundation

// MARK: - Animal

struct Animal {
    let title: String
    let description: String
    let image: URL?
    let order: Int
    let status: Status?
    let content: [FactInfo]?
    
    var isContentEmpty: Bool {
        content == nil || content?.isEmpty ?? true
    }
}

// MARK: - Animal + Decodable

extension Animal: Decodable {
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case image
        case order
        case status
        case content
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        image = .init(string: try container.decode(String.self, forKey: .image))
        order = try container.decode(Int.self, forKey: .order)
        status = .init(rawValue: try container.decode(String.self, forKey: .status))
        content = try container.decodeIfPresent([FactInfo].self, forKey: .content)
    }
}

// MARK: - Animal + Equatable

extension Animal: Equatable {
    static func == (lhs: Animal, rhs: Animal) -> Bool {
        lhs.order == rhs.order
    }
}

// MARK: - Animal + Identifiable

extension Animal: Identifiable {
    var id: Int { order }
}

// MARK: - Status

extension Animal {
    enum Status: String {
        case paid
        case free
    }
}

// MARK: - FactInfo

extension Animal {
    struct FactInfo {
        let fact: String
        let image: URL?
    }
}

// MARK: - FactInfo + Decodable

extension Animal.FactInfo: Decodable {
    enum CodingKeys: String, CodingKey {
        case fact
        case image
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        fact = try container.decode(String.self, forKey: .fact)
        image = try container.decodeIfPresent(URL.self, forKey: .image)
    }
}

// MARK: - FactInfo + Equatable, Identifiable

extension Animal.FactInfo: Equatable, Identifiable, Hashable {
    var id: String { self.fact }
}

typealias Animals = [Animal]
