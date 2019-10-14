//
//  ComponentsInput.swift
//  Spells
//
//  Created by Sergey Melnikov on 11.10.2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

protocol ComponentsInput: AnyObject {
    var spell: Spell! { get set }
    
    func showNextVC()
}
