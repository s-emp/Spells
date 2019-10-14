//
//  CreateSpellbookOutput.swift
//  Spells
//
//  Created by Sergey Melnikov on 03/10/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

protocol CreateSpellbookOutput {

    func createSpellbook(_ name: String)
    
    init(_ view: CreateSpellbookInput, service: SpellService)
}
