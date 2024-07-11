//
//  Animal+Mock.swift
//  AnimalExplorer
//
//  Created by Andrii Boichuk on 11.07.2024.
//

import Foundation

extension Animal {
    static var mock: Self {
        .init(title: "Dogs 🐕",
              description: "Different facts about dogs",
              image: .init(string:"https://upload.wikimedia.org/wikipedia/commons/2/2b/WelshCorgi.jpeg"),
              order: 2,
              status: .paid,
              content: nil)
    }
}
