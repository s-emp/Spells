//
//  ComponentsOutput.swift
//  Spells
//
//  Created by Sergey Melnikov on 11.10.2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

protocol ComponentsOutput {
    
    var spell: Spell! { get set }
    
    func saveComponents(v: Bool, s: Bool, m: Bool, materials: String?)
    init(_ view: ComponentsInput)
}

