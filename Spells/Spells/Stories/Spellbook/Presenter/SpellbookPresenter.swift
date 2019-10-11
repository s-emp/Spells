//
//  SpellbookPresenter.swift
//  Spells
//
//  Created by Sergey Melnikov on 01/10/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

class SpellbookPresenter: SpellbookOutput {
    
    // MARK: - Properties
    var spellbook: Spellbook
    private var service: SpellService!
    weak var view: SpellbookInput!
    
    // MARK: - Methods
    required init(_ view: SpellbookInput, service: SpellService, spellbook: Spellbook) {
        self.view = view
        self.service = service
        self.spellbook = spellbook
    }
}