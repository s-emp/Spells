//
//  AddSpellbookPresenter.swift
//  Spells
//
//  Created by Sergey Melnikov on 03/10/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

class AddSpellbookPresenter: AddSpellbookOutput {
    // MARK: - Properties
    private let service: SpellService
    weak var view: AddSpellbookInput!
    
    // MARK: - Methods
    func createSpellbook(_ name: String) {
        guard !name.isEmpty else {
            view.error("Название не может быть пустым")
            return
        }
        guard service.spellbooks().first(where: { $0.name == name }) == nil else {
            view.error("Такое название уже используется")
            return
        }
        service.addSpellbook(Spellbook(name: name, spells: []))
        view.hide()
    }
    
    required init(_ view: AddSpellbookInput, service: SpellService) {
        self.service = service
        self.view = view
    }
}
