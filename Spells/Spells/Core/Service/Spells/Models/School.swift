//
//  School.swift
//  DnDSpells
//
//  Created by Сергей Мельников on 15/07/2019.
//  Copyright © 2019 Сергей Мельников. All rights reserved.
//

import Foundation
import RealmSwift

class School: Object, Codable {
    @objc dynamic var id = ""
    @objc dynamic var nameRus = ""
    @objc dynamic var nameEng = ""
    @objc dynamic var index = 0
}
