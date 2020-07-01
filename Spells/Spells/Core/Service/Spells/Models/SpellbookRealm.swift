//
//  SpellbookRealm.swift
//  Spells
//
//  Created by Sergey Melnikov on 30/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import RealmSwift

class SpellbookRealm: Object {
    @objc dynamic var name: String = ""
    var spells = List<SpellRealm>()
    
    override static func primaryKey() -> String? {
        return "name"
    }
}
