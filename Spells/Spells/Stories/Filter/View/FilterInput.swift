//
//  FilterInput.swift
//  Spells
//
//  Created by Sergey Melnikov on 25/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

protocol FilterInput: AnyObject {
    
    func updateUI()
    func changeBooks(_ selected: [Book])
    init(_ filter: Filter, spellList: SpellListInput)
}
