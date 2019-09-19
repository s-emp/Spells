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
        case scholl1
        case scholl2
        case scholl3
        case scholl4
        case tabMenuDone
        case text
        case popupBackground
    }
}
