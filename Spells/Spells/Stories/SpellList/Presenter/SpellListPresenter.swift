//
//  SpellListPresenter.swift
//  Spells
//
//  Created by Sergey Melnikov on 24/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

class SpellListPresenter: SpellListOutput {
    // MARK: - Properties
    weak var view: SpellListInput!
    private let service: SpellService
    var filter: Filter
    
    var spells: [Spell]
    
    // MARK: - Methods
    func selectItem(_ index: IndexPath) {
        
    }
    
    func removeSpell(_ spell: Spell) {
        spells.removeAll(where: { $0.uuid == spell.uuid})
        service.removeSpell(spell)
    }
    
    func search(_ message: String?) {
        spells = filter.apply(service.spells())
            .filter { spell in
                message != nil && !message!.isEmpty ? spell.nameQuery.contains(message!.lowercased()) : true
        }
        .sorted { (lv, rv) -> Bool in
            if lv.level < rv.level { return true }
            if lv.level ==  rv.level && lv.name < rv.name { return true }
            return false
        }
        view.reloadTableView()
    }
    
    // MARK: - Init
    required init(_ view: SpellListInput, service: SpellService, filter: Filter) {
        self.view = view
        self.service = service
        self.filter = filter
        self.spells = service.spells()
            .filter { $0.language == Language.systemLanguage }
            .sorted { (lv, rv) -> Bool in
                if lv.level < rv.level { return true }
                if lv.level ==  rv.level && lv.name < rv.name { return true }
                return false
        }
    }
}
