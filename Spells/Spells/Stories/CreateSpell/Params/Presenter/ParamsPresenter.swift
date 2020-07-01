//
//  ParamsPresenter.swift
//  Spells
//
//  Created by Sergey Melnikov on 11.10.2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

class ParamsPresenter: ParamsOutput {
    // MARK: - Properties
    var spell: Spell!
    weak var view: ParamsInput!
    
    // MARK: - Methods
    func saveParams(_ level: Int, school: School, range: String?, duration: String?, action: String?) {
        guard let range = range, !range.isEmpty else {
            view.error("Не указан радиус заклинания")
            return
        }
        guard let duration = duration, !duration.isEmpty else {
            view.error("Не указана продолжительность")
            return
        }
        guard let action = action, !action.isEmpty else {
            view.error("Не указано время наложения заклинания")
            return
        }
        spell.level = level
        spell.school = school
        spell.range = range
        spell.duration = duration
        spell.action = action
        view.showNextVC()
    }
    
    required init(_ view: ParamsInput) {
        self.view = view
    }
}
