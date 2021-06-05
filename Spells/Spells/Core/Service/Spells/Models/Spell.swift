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
    
    func getShortComponents() -> String {
        components.map { $0.shortName(.ru) }.joined(separator: ", ")
    }
    
    func getLevel() -> String {
        level == 0 ? "Трюк" : "Заклинание_\(level)"
    }
    
    func getTags() -> String {
        let spellName = name.split(separator: " ").joined(separator: "_").lowercased()
        let spellProfessions = professions.map { $0.fullName(.ru).lowercased() }.joined(separator: ", ")
        let spellBooks = books.map { $0.rawValue.lowercased() }.joined(separator: ", ")
        let spellComponents = components.map { $0.fullName(.ru).lowercased() }.joined(separator: ", ")
        return "[заклинание, \(getLevel().lowercased()), \(spellName), \(school.fullName(.ru).lowercased()), \(spellProfessions), \(spellBooks), \(spellComponents)]"
    }
    
    func getMarkdown() -> String {
        var material: String?
        if let spellMaterial = materials, !spellMaterial.isEmpty{
            material = "**Материальные компоненты**: \(spellMaterial)"
        }
        return """
        ---
        tags: \(getTags())
        ---
        # \(name)
        **Уровень**: \(getLevel())
        **Время накладывания**: \(action)
        **Дистанция**: \(range)
        **Компоненты**: \(getShortComponents())
        **Длительность**: \(duration)
        **Школа**: \(school.fullName(.ru))
        **Ритуал**: \(isRitual ? "Да" : "Нет")
        \(material ?? "")
        ## Описание
        \(info)
        """
    }
    
    static func save(to url: URL, spells: [Spell]) {
        for spell in spells {
            do {
                guard let data = spell.getMarkdown().data(using: .utf8) else {
                    print("Error get data: \(spell.name)")
                    continue
                }
                let name = "\(spell.name.replacingOccurrences(of: "/", with: "_").lowercased()).md"
                let finalURL = url.appendingPathComponent("\(name)")
                try data.write(to: finalURL)
            } catch {
                print("Save error spell \(spell.name.lowercased()): \(error.localizedDescription)")
            }
        }
        print("Save finish. Files: \(url.absoluteString)")
    }
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
