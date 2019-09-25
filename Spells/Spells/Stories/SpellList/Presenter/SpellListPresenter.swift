//
//  SpellListPresenter.swift
//  Spells
//
//  Created by Sergey Melnikov on 24/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

class SpellListPresenter: SpellListOutput {
    // MARK: - Properties
    weak var view: SpellListInput!
    private let service: SpellService
    
    var spells: [Spell]
    
    // MARK: - Methods
    func selectItem(_ index: IndexPath) {
        
    }
    
    func search(_ message: String) {
        spells = Spell.transform(Array(service.realm.objects(SpellRealm.self).filter("nameQuery LIKE[c] '*\(message.lowercased())*'")))
        view.reloadTableView()
    }
    
    // MARK: - Init
    required init(_ view: SpellListInput, service: SpellService) {
        self.view = view
        self.service = service
        self.spells = service.getSpells()
    }
}
