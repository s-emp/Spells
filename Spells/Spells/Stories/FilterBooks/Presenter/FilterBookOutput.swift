//
//  FilterBookOutput.swift
//  Spells
//
//  Created by Sergey Melnikov on 30/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

protocol FilterBookOutput {
    var filter: Filter { get }
    var playersHandbook: Bool { get set }
    var xanatharsGuideToEverything: Bool { get set }
    var templeOfElementalEvil: Bool { get set }
    var sproutingChaos: Bool { get set }
    var homebrew: Bool { get set }
    
    init(_ view: FilterBookInput, filter: Filter)
}

