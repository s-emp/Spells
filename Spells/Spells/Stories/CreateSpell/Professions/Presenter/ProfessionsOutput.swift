//
//  ProfessionsOutput.swift
//  Spells
//
//  Created by Сергей Мельников on 12.10.2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

protocol ProfessionsOutput {
    var spell: Spell! { get set }
    
    func saveSpell(bard: Bool, wizard: Bool, druid: Bool, cleric: Bool, warlock: Bool, paladin: Bool, ranger: Bool, sorcerer: Bool)
    init(_ view: ProfessionsInput, service: SpellService)
}
