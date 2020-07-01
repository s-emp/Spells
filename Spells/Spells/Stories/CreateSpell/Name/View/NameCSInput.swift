//
//  NameCSInput.swift
//  Spells
//
//  Created by Sergey Melnikov on 10.10.2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

protocol NameCSInput: AnyObject {
    func showNextVC()
    func error(_ message: String)
}
