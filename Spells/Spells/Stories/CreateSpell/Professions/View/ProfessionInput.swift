//
//  ProfessionInput.swift
//  Spells
//
//  Created by Сергей Мельников on 12.10.2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

protocol ProfessionsInput: AnyObject {
    var spell: Spell! { get set }
    
    func success()
}
