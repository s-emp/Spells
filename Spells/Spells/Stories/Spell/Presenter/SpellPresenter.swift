//
//  SpellPresenter.swift
//  Spells
//
//  Created by Sergey Melnikov on 01/10/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

class SpellPresenter: SpellOutput {
    // MARK: - Properties
    weak var view: SpellInput!
    private(set) var spell: Spell
    var isFavorites: Bool {
        return service.favorites.spells.contains(where: { $0.uuid == spell.uuid })
    }
    private let service: SpellService
    
    // MARK: - Methods
    func changeFavorite() {
        if isFavorites {
            service.removeSpellInSpellbook(spell, spellbook: service.favorites)
            view.notification("Заклинание убрано из Избранного")
        } else {
            service.addSpellInSpellbook(spell, spellbook: service.favorites)
            view.notification("Заклинание добавлено в Избранное")
        }
    }
    
    required init(_ view: SpellInput, service: SpellService, spell: Spell) {
        self.view = view
        self.spell = spell
        self.service = service
    }
}
