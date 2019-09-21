//
//  Component.swift
//  DnDSpells
//
//  Created by Сергей Мельников on 17/07/2019.
//  Copyright © 2019 Сергей Мельников. All rights reserved.
//

import Foundation
import RealmSwift
class Component: Object, Codable {
    @objc dynamic var id: String
    @objc dynamic var nameRus: String
    @objc dynamic var nameEng: String
    @objc dynamic var descRus: String
    @objc dynamic var descEng: String
}
