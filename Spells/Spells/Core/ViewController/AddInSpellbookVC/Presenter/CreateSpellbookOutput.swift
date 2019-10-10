//
//  CreateSpellbookOutput.swift
//  Spells
//
//  Created by Sergey Melnikov on 01/10/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

protocol CreateSpellbookOutput {
    
    var spellbooks: [Spellbook] { get }
    
    func touchItem(_ index: Int)
    
    init(_ view: CreateSpellbookInput, service: SpellService, spell: Spell)
}

