//
//  SpellService.swift
//  DnDSpells
//
//  Created by Сергей Мельников on 12/08/2019.
//  Copyright © 2019 Сергей Мельников. All rights reserved.
//

import RealmSwift

class SpellService {
    
    private(set) var realm: Realm?
    
    func getAllSpell() -> Results<Spell> {
        return realm!.objects(Spell.self)
    }
    
    func createSpellBook(_ name: String, spells: [Spell]) {
        let objct = Spellbook()
        objct.name = name
        spells.forEach { objct.spells.append($0) }
        try! realm!.write {
            realm!.add(objct)
        }
    }
    
    // MARK: - Create realm file
    static func createRealmFile() {
        let config = Realm.Configuration()
        let realm = try! Realm(configuration: config)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let books = getBooks(decoder)
        let schools = getSchools(decoder)
        let profession = getProfession(decoder)
        let components = getComponents(decoder)
        let spells = getSpells(decoder)
        
        try! realm.write {
            realm.add(books)
            realm.add(schools)
            realm.add(profession)
            realm.add(components)
        }
        
        var allSpells: [Spell] = []
        for spell in spells {
            let (eng, rus) = Spell.getSpell(spell, realm: realm)
            allSpells.append(eng)
            allSpells.append(rus)
        }
        try! realm.write {
            realm.add(allSpells)
        }
        
        print(realm.configuration.fileURL!.absoluteString)
    }
    
    private static func getComponents(_ decoder: JSONDecoder) -> [Component] {
        let filePath = Bundle.main.path(forResource: "Components", ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: filePath!))
        return try! decoder.decode([Component].self, from: data)
    }
    
    private static func getBooks(_ decoder: JSONDecoder) -> [Book] {
        let filePath = Bundle.main.path(forResource: "Books", ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: filePath!))
        return try! decoder.decode([Book].self, from: data)
    }
    
    private static func getSchools(_ decoder: JSONDecoder) -> [School] {
        let filePath = Bundle.main.path(forResource: "Schools", ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: filePath!))
        return try! decoder.decode([School].self, from: data)
    }
    
    private static func getProfession(_ decoder: JSONDecoder) -> [Profession] {
        let filePath = Bundle.main.path(forResource: "Profession", ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: filePath!))
        return try! decoder.decode([Profession].self, from: data)
    }
    
    private static func getSpells(_ decoder: JSONDecoder) -> [SpellJSON] {
        let filePath = Bundle.main.path(forResource: "Spells", ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: filePath!))
        var spell: [SpellJSON]
        do {
            spell = try decoder.decode([SpellJSON].self, from: data)
        } catch let error {
            print(error)
            fatalError()
        }
        spell.forEach {
            if $0.ru.source == nil {
                $0.ru.source = $0.en.source
            }
            if $0.ru.level == nil {
                $0.ru.level = $0.en.level
            }
        }
        return spell
    }
    
    private static func checkSpells(_ spells: [SpellJSON]) {
        spells.enumerated().forEach { index, spell in
            if spell.ru.level == nil || spell.ru.level!.isEmpty {
                print("Index: \(index) - level is nil")
            }
            if spell.ru.text == nil || spell.ru.text!.isEmpty {
                print("Index: \(index) - text is nil")
            }
            if spell.ru.school == nil || spell.ru.school!.isEmpty {
                print("Index: \(index) - school is nil")
            }
            if spell.ru.castingTime == nil || spell.ru.castingTime!.isEmpty {
                print("Index: \(index) - castingTime is nil")
            }
            if spell.ru.range == nil || spell.ru.range!.isEmpty {
                print("Index: \(index) - range is nil")
            }
            if spell.ru.duration == nil || spell.ru.duration!.isEmpty {
                print("Index: \(index) - duration is nil")
            }
            if spell.ru.source == nil || spell.ru.source!.isEmpty {
                print("Index: \(index) - source is nil")
            }
            if (spell.ru.materials == nil || spell.ru.materials?.isEmpty ?? true) && (!(spell.en.materials?.isEmpty ?? true)) {
                print("Index: \(index) - materials is nil")
            }
            if spell.en.level == nil || spell.en.level!.isEmpty {
                print("Index: \(index) - level is nil")
            }
            if spell.en.text == nil || spell.en.text!.isEmpty {
                print("Index: \(index) - text is nil")
            }
            if spell.en.school == nil || spell.en.school!.isEmpty {
                print("Index: \(index) - school is nil")
            }
            if spell.en.castingTime == nil || spell.en.castingTime!.isEmpty {
                print("Index: \(index) - castingTime is nil")
            }
            if spell.en.range == nil || spell.en.range!.isEmpty {
                print("Index: \(index) - range is nil")
            }
            if spell.en.duration == nil || spell.en.duration!.isEmpty {
                print("Index: \(index) - duration is nil")
            }
            if spell.en.source == nil || spell.en.source!.isEmpty {
                print("Index: \(index) - source is nil")
            }
        }
    }
    
    // MARK: - init
    private let realmName = "Spells"
    
    /// URL до пользовательской директории с документами
    private var documentsURL: URL {
        return try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    }
    
    /// URL до realm в пользовательской директории с документами
    private var realmDocumentURL: URL {
        return documentsURL.appendingPathComponent("\(realmName).realm")
    }
    
    /// URL до realm в Bundle
    private var realmBundleURL: URL {
        return Bundle.main.url(forResource: realmName, withExtension: "realm")!
    }
    
    /// Проверка realm файла в пользовательской директории с документами
    ///
    /// - Returns: Находится ли realm файл в пользовательской директории?
    private func checkRealmFileInDocuments() -> Bool {
        return (try? realmDocumentURL.checkResourceIsReachable()) ?? false
    }
    
    /// Копирование realm файла из Bundle в пользовательскую директорию с документами
    ///
    /// - Returns: Удалось ли скопировать realm файл?
    private func copyRealmFileInDocuments() -> Bool {
        do {
            try FileManager.default.copyItem(at: realmBundleURL, to: realmDocumentURL)
            return true
        } catch {
            return false
        }
    }
    
    /// Открыть realm файл который лежит в пользовательской директории с документами. Если его нету, ничего не происходит.
    private func openRealmFileInDocuments() {
        let config = Realm.Configuration(fileURL: realmDocumentURL, readOnly: false, schemaVersion: 1, migrationBlock: { migration, schemaVersion in })
        realm = try? Realm(configuration: config)
    }
    
    /// Открыть realm файл который находится в Bundle. Если его нету, ничего не происходит.
    private func openRealmFileInBundle() {
        let config = Realm.Configuration(fileURL: realmBundleURL, readOnly: true, schemaVersion: 1, migrationBlock: { migration, schemaVersion in })
        realm = try? Realm(configuration: config)
    }
    
    /// Подготовка realm
    private func prepareRealmDB() {
        if checkRealmFileInDocuments() {
            openRealmFileInDocuments()
        } else {
            if copyRealmFileInDocuments() {
                openRealmFileInDocuments()
            } else {
                openRealmFileInBundle()
            }
        }
        print("URL REALM: \(realm?.configuration.fileURL?.absoluteString ?? "-")")
    }
    
    private init() {
        prepareRealmDB()
    }
    
    private static var spellService: SpellService?
    static func shared() -> SpellService {
        if SpellService.spellService == nil {
            SpellService.spellService = SpellService()
        }
        return SpellService.spellService!
    }
}
