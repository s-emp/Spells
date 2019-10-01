//
//  Spellbook.swift
//  Spells
//
//  Created by Sergey Melnikov on 30/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

struct Spellbook {
    var name: String
    var spells: [Spell]
}

extension Spellbook {
    static func transform(_ spellbook: SpellbookRealm) -> Spellbook {
        let spells = Array(spellbook.spells.map { Spell.transform($0) })
        return Spellbook(name: spellbook.name, spells: spells)
    }
}
