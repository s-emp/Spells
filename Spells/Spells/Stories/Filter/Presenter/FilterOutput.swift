//
//  FilterOutput.swift
//  Spells
//
//  Created by Sergey Melnikov on 26/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

protocol FilterOutput {
    
    var resultCount: Int { get }
    var professions: [Profession] { get }
    var filter: Filter { get set }
    
    func resetFilter()
    func changeSelectedProfessions(_ selected: [Profession])
    func changeSelectedLevels(_ selected: [Int])
    func changeValueConcentration()
    func changeValueRitual()
    func changeBooks(_ selected: [Book])
    
    init(_ view: FilterInput, service: SpellService, filter: Filter)
}

