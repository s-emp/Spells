//
//  SpellN.swift
//  Spells
//
//  Created by Сергей Мельников on 21/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit

struct Spell: Codable {
    let uuid: String
    var level: Int
    var name: String
    var school: School
    var action: String
    var duration: String
    var range: String
    var info: String
    var components: [Component]
    var materials: String?
    var professions: [Profession]
    var books: [Book]
    var isConcentration: Bool
    var isRitual: Bool
    var nameQuery: String
    var language: Language
}

// MARK: - Transform
extension Spell {
    static func transform(_ spell: SpellRealm) -> Spell {
        let components = spell.components.split(separator: ",").map { Component(rawValue: String($0))! }
        let professions = spell.professions.split(separator: ",").map { Profession(rawValue: String($0))! }
        let books = spell.books.split(separator: ",").map { Book(rawValue: String($0))! }
        return Spell(uuid: spell.uuid, level: spell.level, name: spell.name, school: School(rawValue: spell.school)!, action: spell.action, duration: spell.duration, range: spell.range, info: spell.info, components: components, materials: spell.materials, professions: professions, books: books, isConcentration: spell.isConcentration, isRitual: spell.isRitual, nameQuery: spell.nameQuery, language: Language(rawValue: spell.language)!)
    }
    
    static func transform(_ spells: [SpellRealm]) -> [Spell] {
        return spells.map { Spell.transform($0) }
    }
}
