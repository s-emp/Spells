//
//  String+Capitalizing.swift
//  Spells
//
//  Created by Сергей Мельников on 05.06.2021.
//  Copyright © 2021 Sergey Melnikov. All rights reserved.
//

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
