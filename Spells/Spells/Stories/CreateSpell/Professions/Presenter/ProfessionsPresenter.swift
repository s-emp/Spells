//
//  ProfessionsPresenter.swift
//  Spells
//
//  Created by Сергей Мельников on 13.10.2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

class ProfessionsPresenter: ProfessionsOutput {
    var spell: Spell!
    
    private weak var view: ProfessionsInput!
    let service: SpellService
    
    func saveSpell(bard: Bool, wizard: Bool, druid: Bool, cleric: Bool, warlock: Bool, paladin: Bool, ranger: Bool, sorcerer: Bool) {
        var result = [Profession]()
        
    }
    
    required init(_ view: ProfessionsInput, service: SpellService) {
        self.view = view
        self.service = service
    }
}
