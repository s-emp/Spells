//
//  Int+Declension.swift
//  Spells
//
//  Created by Sergey Melnikov on 26/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

extension Int {
    func declension(_ declension: [String]) -> String {
        var tmp = self % 100
        if tmp >= 11 && tmp <= 19 {
            return declension[2]
        } else {
            tmp = tmp % 10
            switch tmp {
            case 1: return declension[0]
            case 2,3,4: return declension[1]
            default: return declension[2]
            }
        }
    }
}
