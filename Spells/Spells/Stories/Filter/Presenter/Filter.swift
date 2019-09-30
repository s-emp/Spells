//
//  Filter.swift
//  Spells
//
//  Created by Sergey Melnikov on 26/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

struct Filter {
    var levels: [Int]
    var professions: [Profession]
    var isConcentration: Bool
    var isRitual: Bool
    var books: [Book]
}

extension Filter {
    func apply(_ source: [Spell]) -> [Spell] {
        return source
            .filter({ spell -> Bool in
                guard self.professions.count > 0 else { return true }
                for profession in self.professions where spell.professions.contains(profession) {
                    return true
                }
                return false
            })
            .filter({ spell -> Bool in
                guard self.books.count > 0 else { return true }
                for book in self.books where spell.books.contains(book) {
                    return true
                }
                return false
            })
            .filter { self.levels.count > 0 ? self.levels.contains($0.level) : true }
            .filter { self.isConcentration ? $0.isConcentration : true }
            .filter { self.isRitual ? $0.isRitual : true}
    }
}
