//
//  SpellbookListPresenter.swift
//  Spells
//
//  Created by Sergey Melnikov on 01/10/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

class SpellbookListPresenter: SpellbookListOutput {
    var spellbooks: [Spellbook] {
        return service.spellbooks()
    }
    
    // MARK: - Properties
    weak var view: SpellbookListInput!
    let service: SpellService
    
    // MARK: - Methods
    func remove(_ spellboook: Spellbook) {
        service.removeSpellbook(spellboook)
    }
    
    required init(_ view: SpellbookListInput, service: SpellService) {
        self.view = view
        self.service = service
    }
}
