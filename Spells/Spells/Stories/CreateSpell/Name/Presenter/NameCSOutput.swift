//
//  NameCSOutput.swift
//  Spells
//
//  Created by Sergey Melnikov on 10.10.2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

protocol NameCSOutput {
    
    var spell: Spell { get }
    
    func saveName(_ name: String?)
    init(_ view: NameCSInput, service: SpellService)
}

