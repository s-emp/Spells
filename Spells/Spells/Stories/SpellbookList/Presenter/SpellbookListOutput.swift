//
//  SpellbookListOutput.swift
//  Spells
//
//  Created by Sergey Melnikov on 01/10/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

protocol SpellbookListOutput {
    
    var spellbooks: [Spellbook] { get }
    func remove(_ spellboook: Spellbook)
    init(_ view: SpellbookListInput, service: SpellService)
}

