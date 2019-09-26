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
            resetDataBase()
        }
        print("DataBase url: \(realm.configuration.fileURL?.absoluteString ?? "???")")
    }
    
    // MARK: - Methods
    func resetDataBase() {
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
    
    func getSpells() -> [Spell] {
        let spellsRealm = realm.objects(SpellRealm.self)
        return Array(spellsRealm.map { Spell.transform($0) }).filter { $0.language == Language.systemLanguage }
    }
}
