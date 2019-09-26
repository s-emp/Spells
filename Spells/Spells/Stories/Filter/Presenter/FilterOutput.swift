//
//  FilterOutput.swift
//  Spells
//
//  Created by Sergey Melnikov on 26/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

protocol FilterOutput {
    
    var filter: Filter { get }
    func resetFilter()
    
    init(_ view: FilterInput, service: SpellService, filter: Filter)
}

