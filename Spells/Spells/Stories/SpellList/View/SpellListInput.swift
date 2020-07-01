//
//  SpellListInput.swift
//  Spells
//
//  Created by Сергей Мельников on 20/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

protocol SpellListInput: AnyObject {
    func applyFilter(_ filter: Filter)
    func reloadTableView()
}
