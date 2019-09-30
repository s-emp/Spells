//
//  UIColor+Palette.swift
//  Spells
//
//  Created by Sergey Melnikov on 19/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init?(named: UIColor.Palette) {
        self.init(named: named.rawValue)
    }
    
    enum Palette: String {
        case background
        case buttonDisabled
        case icon
        case level
        case plusBackground
        case plusBackgroundDisabled
        case tabMenuDone
        case text
        case popupBackground
        case searchTextField
        case abjuration
        case conjuration
        case divination
        case enchantment
        case evocation
        case illusion
        case necromancy
        case transmutation
        case other
        case diceTextColor
    }
}
