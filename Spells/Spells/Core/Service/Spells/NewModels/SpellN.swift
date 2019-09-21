//
//  SpellN.swift
//  Spells
//
//  Created by Сергей Мельников on 21/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

struct SpellN {
    var level: Int
    var name: String
    var school: SchoolN
    var action: String
    var duration: String
    var range: String
    var info: String
    var components: [ComponentN]
    var materials: String?
    var professions: [ProfessionN]
    var source: [BookN]
    var isConcentration: Bool
    var isRitual: Bool
    var nameQuery: String
}

//@objc dynamic var level: Int = 0
//@objc dynamic var name: String = ""
//@objc dynamic var school: School?
//@objc dynamic var action: String = ""
//@objc dynamic var range: String = ""
//var components = List<Component>()
//@objc dynamic var duration: String = ""
//@objc dynamic var spellDescription: String = ""
//var professions = List<Profession>()
//var source = List<Book>()
//@objc dynamic var language: String = ""
//@objc dynamic var isConcentration: Bool = false
//@objc dynamic var isRitual: Bool = false
//@objc dynamic var nameQuery: String = ""
//@objc dynamic var materials: String?
