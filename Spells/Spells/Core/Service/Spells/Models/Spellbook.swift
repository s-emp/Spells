//
//  Spellbook.swift
//  DnDSpells
//
//  Created by Сергей Мельников on 12/08/2019.
//  Copyright © 2019 Сергей Мельников. All rights reserved.
//

import RealmSwift

class Spellbook: Object {
    @objc dynamic var name: String = ""
    var spells = List<Spell>()
}
