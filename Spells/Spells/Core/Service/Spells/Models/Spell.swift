//
//  SpellN.swift
//  Spells
//
//  Created by Сергей Мельников on 21/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit

struct Spell: Codable {
    let uuid: String
    var level: Int
    var name: String
    var school: School
    var action: String
    var duration: String
    var range: String
    var info: String
    var components: [Component]
    var materials: String?
    var professions: [Profession]
    var books: [Book]
    var isConcentration: Bool
    var isRitual: Bool
    var nameQuery: String
}
