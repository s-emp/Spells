//
//  NameCSPresenter.swift
//  Spells
//
//  Created by Sergey Melnikov on 10.10.2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

class NameCSPresenter: NameCSOutput {
    // MARK: - Properties
    weak var view: NameCSInput!
    let service: SpellService
    var spell = Spell(uuid: UUID().uuidString, level: 0, name: "", school: School.other, action: "", duration: "", range: "", info: "", components: [], materials: nil, professions: [], books: [.HB], isConcentration: false, isRitual: false, nameQuery: "", language: .ru)
    
    // MARK: - Methods
    func saveName(_ name: String?) {
        guard name != nil && !name!.isEmpty else {
            view.error("Введите название заклинания")
            return
        }
        guard service.spells().first(where: { $0.name == name }) == nil else {
            view.error("Заклинание с таким названием уже существует")
            return
        }
        spell.name = name!
        view.showNextVC()
    }
    
    required init(_ view: NameCSInput, service: SpellService) {
        self.view = view
        self.service = service
    }
}
