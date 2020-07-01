//
//  Exported.swift
//  DnDSpells
//
//  Created by Сергей Мельников on 29/08/2019.
//  Copyright © 2019 Сергей Мельников. All rights reserved.
//

import Foundation
import RealmSwift

protocol Exported {
    static func export<T: Encodable>(_ url: URL, objects: [T]) throws
}

extension Exported {
    static func export<T: Encodable>(_ url: URL, objects: [T]) throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(objects)
        try data.write(to: url, options: .atomicWrite)
    }
}
