//
//  SpellRealm.swift
//  Spells
//
//  Created by Sergey Melnikov on 24/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation
import RealmSwift

class SpellRealm: Object {
    @objc dynamic var uuid: String = ""
    @objc dynamic var level: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var school: String = ""
    @objc dynamic var action: String = ""
    @objc dynamic var duration: String = ""
    @objc dynamic var range: String = ""
    @objc dynamic var info: String = ""
    @objc dynamic var components: String = ""
    @objc dynamic var materials: String?
    @objc dynamic var professions: String = ""
    @objc dynamic var books: String = ""
    @objc dynamic var isConcentration: Bool = false
    @objc dynamic var isRitual: Bool = false
    @objc dynamic var nameQuery: String = ""
    
    override static func primaryKey() -> String? {
        return "uuid"
    }
}

// MARK: - Transformation
extension SpellRealm {
    static func transform(_ spell: Spell) -> SpellRealm {
        let result: SpellRealm = SpellRealm()
        result.uuid = spell.uuid
        result.level = spell.level
        result.name = spell.name
        result.school = spell.school.rawValue
        result.action = spell.action
        result.duration = spell.duration
        result.range = spell.range
        result.info = spell.info
        result.components = spell.components.map { $0.rawValue }
            .joined(separator: ",")
        result.materials = spell.materials
        result.professions = spell.professions.map { $0.rawValue }
            .joined(separator: ",")
        result.books = spell.books.map { $0.rawValue }
            .joined(separator: ",")
        result.isConcentration = spell.isConcentration
        result.isRitual = spell.isRitual
        result.nameQuery = spell.nameQuery
        return result
    }
}
