//
//  Book.swift
//  Spells
//
//  Created by Сергей Мельников on 20/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

enum Book: String, Codable {
    case PHB
    case TOEE
    case SCPC
    case XGTE
    case HB
    
    func fullName(_ language: Language) -> String {
        switch language {
        case .ru:
            switch self {
            case .PHB:
                return "Книга игрока"
            case .TOEE:
                return "Храм стихийного зла"
            case .SCPC:
                return "Прорастающий Хаос"
            case .XGTE:
                return "Руководство Занатара обо всем"
            case .HB:
                return "Самопал"
            }
        case .en:
            switch self {
            case .PHB:
                return "Palyers Handbook"
            case .TOEE:
                return "Temple of Elemental Evil"
            case .SCPC:
                return "Sprouting Chaos"
            case .XGTE:
                return "Xanathar's Guide to Everything"
            case .HB:
                return "Homebrew"
            }
        }
    }
}

extension Book: CustomStringConvertible {
    var description: String {
        return self.rawValue
    }
}
