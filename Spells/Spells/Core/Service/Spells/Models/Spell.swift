//
//  Spell.swift
//  DnDSpells
//
//  Created by Сергей Мельников on 17/07/2019.
//  Copyright © 2019 Сергей Мельников. All rights reserved.
//

import Foundation
import RealmSwift

var allDuration: [String: Int] = [:]

class Spell: Object, Codable {
    @objc dynamic var level: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var school: School?
    @objc dynamic var action: String = ""
    @objc dynamic var range: String = ""
    var components = List<Component>()
    @objc dynamic var duration: String = ""
    @objc dynamic var spellDescription: String = ""
    var professions = List<Profession>()
    var source = List<Book>()
    @objc dynamic var language: String = ""
    @objc dynamic var isConcentration: Bool = false
    @objc dynamic var isRitual: Bool = false
    @objc dynamic var nameQuery: String = ""
    @objc dynamic var materials: String?
    
    override static func indexedProperties() -> [String] {
        return ["level", "name"]
    }
    
    override static func primaryKey() -> String? {
        return "name"
    }
    
    static func getSpell(_ spell: SpellJSON, realm: Realm) -> (en: Spell, ru: Spell) {
        let resultE = Spell()
        let resultR = Spell()
        resultE.level = Int((spell.en.level ?? "-1")) ?? -1
        resultE.name = spell.en.name
        resultE.school = realm.objects(School.self).first { $0.id.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).lowercased() == spell.en.school?.lowercased() }
        resultE.action = spell.en.castingTime ?? ""
        resultE.range = spell.en.range ?? ""
        let tmpComps = (spell.en.components ?? "").split(separator: ",")
        for comp in tmpComps {
            if let component = realm.objects(Component.self).first(where: { $0.id.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == String(comp).trimmingCharacters(in: .whitespacesAndNewlines).lowercased() }) {
                resultE.components.append(component)
            }
        }
        resultE.materials = spell.en.materials
        resultE.duration = spell.en.duration ?? ""
        let spellDescE = (spell.en.text ?? "").replacingOccurrences(of: "<br>", with: "\n")
        resultE.spellDescription = spellDescE
        for prof in spell.en.class ?? [] {
            if let profession = realm.objects(Profession.self).first(where: { $0.id == prof }) {
                resultE.professions.append(profession)
            }
            if !resultE.isRitual {
                let filePath = Bundle.main.path(forResource: prof + "Spells", ofType: "txt")
                let data = try! Data(contentsOf: URL(fileURLWithPath: filePath!))
                let spellsWizard = String(data: data, encoding: .utf8)!.lowercased().split(separator: "\n").map { String($0) }
                if let tmpName = spellsWizard.first(where: { $0.lowercased().contains(spell.en.name.lowercased()) }) {
                    if tmpName.lowercased().contains("ritual") {
                        resultE.isRitual = true
                    }
                }
            }
            
        }
        let tmpSources = (spell.en.source ?? "").split(separator: ",")
        for item in tmpSources {
            if let source = realm.objects(Book.self).first(where: { $0.id.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == String(item).trimmingCharacters(in: .whitespacesAndNewlines).lowercased() }) {
                resultE.source.append(source)
            }
        }
        resultE.language = "en"
        resultE.isConcentration = spell.en.duration?.contains("Concentration") ?? false
        resultE.nameQuery = spell.en.name.lowercased() + spell.ru.name.lowercased()
        
        resultR.materials = spell.ru.materials
        resultR.level = resultE.level
        resultR.name = spell.ru.name
        resultR.school = resultE.school
        resultR.action = spell.ru.castingTime ?? ""
        resultR.range = spell.ru.range ?? ""
        resultR.components = resultE.components
        resultR.duration = spell.ru.duration ?? ""
        let spellDescR = (spell.ru.text ?? spell.en.text ?? "").replacingOccurrences(of: "<br>", with: "\n")
        resultR.spellDescription = spellDescR
        resultR.professions = resultE.professions
        resultR.source = resultE.source
        resultR.language = "ru"
        resultR.isConcentration = resultE.isConcentration
        resultR.isRitual = resultE.isRitual
        resultR.nameQuery = resultE.nameQuery
        return (resultE, resultR)
    }
}
