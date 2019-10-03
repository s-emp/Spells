//
//  CreateListPresenter.swift
//  Spells
//
//  Created by Сергей Мельников on 20/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

class CreateListPresenter: CreateListOutput {
    private weak var view: CreateListInput!
    
    func createSpell() {
        print("CreateSpell")
    }
    
    func createSpellbook() {
        view.showAddSpellbookVC()
    }
    
    required init(_ view: CreateListInput) {
        self.view = view
    }
}
