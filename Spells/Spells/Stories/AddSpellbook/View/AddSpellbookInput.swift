//
//  AddSpellbookInput.swift
//  Spells
//
//  Created by Sergey Melnikov on 03/10/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

protocol AddSpellbookInput: AnyObject {
    func hide()
    func error(_ message: String)
}
