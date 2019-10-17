//
//  SpellbookOutput.swift
//  Spells
//
//  Created by Sergey Melnikov on 01/10/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

protocol SpellbookOutput {
    var spellbook: Spellbook { get set }
    
    func remove(spellInBookspell spell: Spell)
    init(_ view: SpellbookInput, service: SpellService, spellbook: Spellbook)
}

