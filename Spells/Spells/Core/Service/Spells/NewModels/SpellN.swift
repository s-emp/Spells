//
//  SpellN.swift
//  Spells
//
//  Created by Сергей Мельников on 21/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

struct SpellN: Codable {
    var level: Int
    var name: String
    var school: SchoolN
    var action: String
    var duration: String
    var range: String
    var info: String
    var components: [ComponentN]
    var materials: String?
    var professions: [ProfessionN]
    var source: [BookN]
    var isConcentration: Bool
    var isRitual: Bool
    var nameQuery: String
}

extension SpellN {
    static func transform(_ spell: Spell) -> Self {
        let components = Arrayt(spell.components.map { ComponentN.transform($0) })
        return SpellN(level: spell.level, name: spell.name, school: SchoolN.transform(spell.school!), action: spell.action, duration: spell.duration, range: spell.range, info: spell.spellDescription, components: <#T##[ComponentN]#>, materials: <#T##String?#>, professions: <#T##[ProfessionN]#>, source: <#T##[BookN]#>, isConcentration: <#T##Bool#>, isRitual: <#T##Bool#>, nameQuery: <#T##String#>)
    }
}
