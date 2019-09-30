//
//  SpellListOutput.swift
//  Spells
//
//  Created by Sergey Melnikov on 24/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

protocol SpellListOutput {
    var spells: [Spell] { get }
    var filter: Filter { get set }
    
    func selectItem(_ index: IndexPath)
    func search(_ message: String?)
    
    init(_ view: SpellListInput, service: SpellService, filter: Filter)
}
