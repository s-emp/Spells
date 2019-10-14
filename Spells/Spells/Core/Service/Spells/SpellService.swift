//
//  SpellService.swift
//  DnDSpells
//
//  Created by Сергей Мельников on 12/08/2019.
//  Copyright © 2019 Сергей Мельников. All rights reserved.
//

import RealmSwift

class SpellService: Exported, Imported {
    
    // MARK: - Singleton
    private static var service: SpellService?
    static func shared() -> SpellService {
        if service == nil {
            service = SpellService()
        }
        return service!
    }
    
    private(set) var realm: Realm
    
    // MARK: - Life cycle
    private init() {
        realm = try! Realm(configuration: Realm.Configuration.defaultConfiguration)
        if realm.objects(SpellRealm.self).count == 0 {
            resetSpellDataBase()
        }
        if realm.objects(SpellbookRealm.self).count == 0 {
            resetSpellbookDataBase()
        }
        print("DataBase url: \(realm.configuration.fileURL?.absoluteString ?? "???")")
    }
    
    // MARK: - Methods
    func resetSpellDataBase() {
        guard let url = Bundle.main.url(forResource: "Spell", withExtension: "json") else { fatalError("Отсутствует файл Spell.json в Bundle") }
        do {
            let allSpells: [Spell] = try SpellService.import(url)
            let allSpellRealm = allSpells.map { SpellRealm.transform($0) }
            try realm.write {
                realm.deleteAll()
                realm.add(allSpellRealm)
            }
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
    
    func resetSpellbookDataBase() {
        let favorites = SpellbookRealm()
        favorites.name = Spellbook.favorites
        favorites.spells.append(realm.objects(SpellRealm.self).first!)
        do {
            try realm.write {
                realm.delete(realm.objects(SpellbookRealm.self))
                realm.add(favorites)
            }
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
    
    func spells() -> [Spell] {
        let spellsRealm = realm.objects(SpellRealm.self)
        return Array(spellsRealm.map { Spell.transform($0) }).filter { $0.language == Language.systemLanguage }
    }
    
    func spellbooks() -> [Spellbook] {
        let spellbooksRealm = realm.objects(SpellbookRealm.self)
        return Array(spellbooksRealm.map { Spellbook.transform($0) })
    }
    
    var favorites: Spellbook {
        return Spellbook.transform(realm.objects(SpellbookRealm.self).first(where: { $0.name == Spellbook.favorites })!)
    }
    
    func addSpellInSpellbook(_ spell: Spell, spellbook: Spellbook) {
        guard let spellbookRealm = realm.objects(SpellbookRealm.self).first(where: { $0.name == spellbook.name }) else {
            fatalError("Не найдена книга заклинаний [\(spellbook)] в Realm")
        }
        guard let spellRealm = realm.objects(SpellRealm.self).first(where: { $0.uuid == spell.uuid }) else {
            fatalError("Не найдено заклинание [\(spell)] в Realm")
        }
        do {
            try realm.write {
                spellbookRealm.spells.append(spellRealm)
            }
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
    
    func removeSpellInSpellbook(_ spell: Spell, spellbook: Spellbook) {
        guard let spellbookRealm = realm.objects(SpellbookRealm.self).first(where: { $0.name == spellbook.name }) else {
            fatalError("Не найдена книга заклинаний [\(spellbook)] в Realm")
        }
        guard let spellRealm = realm.objects(SpellRealm.self).first(where: { $0.uuid == spell.uuid }) else {
            fatalError("Не найдено заклинание [\(spell)] в Realm")
        }
        do {
            guard let index = spellbookRealm.spells.index(of: spellRealm) else { return }
            try realm.write {
                spellbookRealm.spells.remove(at: index)
            }
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
    
    func addSpellbook(_ spellbook: Spellbook) {
        guard spellbooks().first(where: { $0.name == spellbook.name }) == nil else { return }
        let spellbookRealm = SpellbookRealm()
        spellbookRealm.name = spellbook.name
        do {
            try realm.write {
                realm.add(spellbookRealm)
            }
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
    
    func removeSpellbook(_ spellbook: Spellbook) {
        guard let spellbookRealm = realm.objects(SpellbookRealm.self).first(where: { $0.name == spellbook.name} ) else { return }
        do {
            try realm.write {
                realm.delete(spellbookRealm)
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func addSpell(_ spell: Spell) {
        guard spells().first(where: { $0.name == spell.name || $0.uuid == spell.uuid }) == nil else { return }
        let spellRealm = SpellRealm.transform(spell)
        do {
            try realm.write {
                realm.add(spellRealm)
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
