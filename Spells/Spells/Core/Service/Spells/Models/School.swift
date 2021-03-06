//
//  School.swift
//  Spells
//
//  Created by Сергей Мельников on 20/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

enum School: String, Codable, CaseIterable {
    case conjuration
    case abjuration
    case necromancy
    case evocation
    case enchantment
    case transmutation
    case illusion
    case divination
    case other
    
    func fullName(_ language: Language) -> String {
        switch language {
        case .ru:
            switch self {
            case .conjuration:
                return "Призыв"
            case .abjuration:
                return "Ограждение"
            case .necromancy:
                return "Некромантия"
            case .evocation:
                return "Проявление"
            case .enchantment:
                return "Очарование"
            case .transmutation:
                return "Преобразование"
            case .illusion:
                return "Иллюзия"
            case .divination:
                return "Прорицание"
            case .other:
                return "Другое"
            }
        case .en:
            switch self {
            case .conjuration:
                return "Conjuration"
            case .abjuration:
                return "Abjuration"
            case .necromancy:
                return "Necromancy"
            case .evocation:
                return "Evocation"
            case .enchantment:
                return "Enchantment"
            case .transmutation:
                return "Transmutation"
            case .illusion:
                return "Illusion"
            case .divination:
                return "Divination"
            case .other:
                return "Other"
            }
        }
    }
}

extension School: CustomStringConvertible {
    var description: String {
        return self.rawValue
    }
}
