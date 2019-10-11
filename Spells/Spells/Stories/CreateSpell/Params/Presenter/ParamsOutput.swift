//
//  ParamsOutput.swift
//  Spells
//
//  Created by Sergey Melnikov on 11.10.2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

protocol ParamsOutput {
    
    var spell: Spell! { get set }
    
    func saveParams(_ level: Int, school: School, range: String?, duration: String?, action: String?)
    init(_ view: ParamsInput)
}

