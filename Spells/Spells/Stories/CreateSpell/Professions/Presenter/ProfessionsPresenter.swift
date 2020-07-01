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
        var professions = [Profession]()
        if bard { professions.append(Profession.bard) }
        if wizard { professions.append(Profession.wizard) }
        if druid { professions.append(Profession.druid) }
        if cleric { professions.append(Profession.cleric) }
        if warlock { professions.append(Profession.warlock) }
        if paladin { professions.append(Profession.paladin) }
        if ranger { professions.append(Profession.ranger) }
        if sorcerer { professions.append(Profession.sorcerer) }
        spell.professions = professions
        service.addSpell(spell)
        view.success()
    }
    
    required init(_ view: ProfessionsInput, service: SpellService) {
        self.view = view
        self.service = service
    }
}
