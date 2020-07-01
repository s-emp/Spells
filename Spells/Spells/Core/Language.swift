//
//  Language.swift
//  Spells
//
//  Created by Сергей Мельников on 20/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

enum Language: String, Codable {
    case ru
    case en
}

extension Language {
    static var systemLanguage: Language = .ru
}
