//
//  CreateListOutput.swift
//  Spells
//
//  Created by Сергей Мельников on 20/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

protocol CreateListOutput {
    
    func createSpell()
    func createSpellbook()
    
    init(_ view: CreateListInput)
}
