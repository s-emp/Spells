//
//  Profession.swift
//  Spells
//
//  Created by Сергей Мельников on 20/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

enum Profession: String, Codable, CaseIterable {
    case bard
    case cleric
    case druid
    case paladin
    case ranger
    case sorcerer
    case warlock
    case wizard
    
    func fullName(_ language: Language) -> String {
        switch language {
        case .ru:
            switch self {
            case .bard:
                return "Бард"
            case .cleric:
                return "Жрец"
            case .druid:
                return "Друид"
            case .paladin:
                return "Паладин"
            case .ranger:
                return "Ренджер"
            case .sorcerer:
                return "Чародей"
            case .warlock:
                return "Колдун"
            case .wizard:
                return "Волшебник"
            }
        case .en:
            switch self {
            case .bard:
                return "Bard"
            case .cleric:
                return "Cleric"
            case .druid:
                return "Druid"
            case .paladin:
                return "Paladin"
            case .ranger:
                return "Ranger"
            case .sorcerer:
                return "Sorcerer"
            case .warlock:
                return "Warlock"
            case .wizard:
                return "Wizard"
            }
        }

    }
}

extension Profession: CustomStringConvertible {
    var description: String {
        return self.rawValue
    }
}
