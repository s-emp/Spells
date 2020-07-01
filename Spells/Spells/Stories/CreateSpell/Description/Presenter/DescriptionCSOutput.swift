//
//  DescriptionCSOutput.swift
//  Spells
//
//  Created by Sergey Melnikov on 10.10.2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

protocol DescriptionCSOutput {
    
    var spell: Spell! { get set }
    
    func saveInformation(_ info: String?)
    init(_ view: DescriptionCSInput)
}

