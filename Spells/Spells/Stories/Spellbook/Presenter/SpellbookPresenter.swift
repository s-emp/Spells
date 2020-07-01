//
//  SpellbookPresenter.swift
//  Spells
//
//  Created by Sergey Melnikov on 01/10/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

class SpellbookPresenter: SpellbookOutput {
    
    // MARK: - Properties
    var spellbook: Spellbook
    private var service: SpellService!
    weak var view: SpellbookInput!
    
    // MARK: - Methods
    
    func remove(spellInBookspell spell: Spell) {
        service.removeSpellInSpellbook(spell, spellbook: spellbook)
        spellbook = service.spellbooks().first(where: { $0.name == spellbook.name })!
    }
    
    required init(_ view: SpellbookInput, service: SpellService, spellbook: Spellbook) {
        self.view = view
        self.service = service
        self.spellbook = spellbook
        self.spellbook.spells = self.spellbook.spells.sorted { (lv, rv) -> Bool in
                if lv.level < rv.level { return true }
                if lv.level ==  rv.level && lv.name < rv.name { return true }
                return false
        }
    }
}
