//
//  SpellJSON.swift
//  DnDSpells
//
//  Created by Сергей Мельников on 15/07/2019.
//  Copyright © 2019 Сергей Мельников. All rights reserved.
//

import Foundation
import RealmSwift
class SpellJSON: Codable {
    var en: LocalizedSkill
    var ru: LocalizedSkill
}

class LocalizedSkill: Codable {
    var name: String = ""
    var level: String? = ""
    var text: String? = ""
    var school: String? = ""
    var castingTime: String? = ""
    var range: String? = ""
    var materials: String? = ""
    var components: String? = ""
    var duration: String? = ""
    var source: String? = ""
    var `class`: [String]? = []
}
