//
//  ComponentsPresenter.swift
//  Spells
//
//  Created by Sergey Melnikov on 11.10.2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

class ComponentsPresenter: ComponentsOutput {
    var spell: Spell!
    
    // MARK: - Properties
    
    weak var view: ComponentsInput!
    
    // MARK: - Methods
    
    func saveComponents(v: Bool, s: Bool, m: Bool, materials: String?) {
        var result = [Component]()
        if v { result.append(Component.v) }
        if s { result.append(Component.s) }
        if m {
            result.append(Component.m)
            spell.materials = materials
        }
        spell.components = result
        view.showNextVC()
    }
    required init(_ view: ComponentsInput) {
        self.view = view
    }
}
