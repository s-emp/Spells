//
//  AddInSpellbookPresenter.swift
//  Spells
//
//  Created by Sergey Melnikov on 01/10/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

class AddInSpellbookPresenter: AddInSpellbookOutput {
    // MARK: - Properties
    private let service: SpellService
    private let spell: Spell
    weak var view: AddInSpellbookInput!
    var spellbooks: [Spellbook]
    
    // MARK: - Methods
    func touchItem(_ index: Int) {
        spellbooks[index].spells.append(spell)
        service.addSpellInSpellbook(spell, spellbook: spellbooks[index])
        view.hide()
    }
    
    required init(_ view: AddInSpellbookInput, service: SpellService, spell: Spell) {
        self.view = view
        self.service = service
        self.spell = spell
        self.spellbooks = service.spellbooks()
    }
}
