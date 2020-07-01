//
//  Imported.swift
//  DnDSpells
//
//  Created by Сергей Мельников on 29/08/2019.
//  Copyright © 2019 Сергей Мельников. All rights reserved.
//

import Foundation

protocol Imported {
    static func `import`<T: Codable>(_ url: URL) throws -> T
}

extension Imported {
    static func `import`<T: Codable>(_ url: URL) throws -> T {
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
