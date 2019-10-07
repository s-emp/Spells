//
//  SpellOutput.swift
//  Spells
//
//  Created by Sergey Melnikov on 01/10/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

protocol SpellOutput {
    var spell: Spell { get }
    var isFavorites: Bool { get }
    
    func changeFavorite()
    init(_ view: SpellInput, service: SpellService, spell: Spell)
}

