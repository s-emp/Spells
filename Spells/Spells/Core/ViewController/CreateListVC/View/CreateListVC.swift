//
//  CreateListVC.swift
//  Spells
//
//  Created by Sergey Melnikov on 19/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit

class CreateListVC: UIViewController {
    
    private var presenter: CreateListOutput!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = CreateListPresenter(self)
    }

    @IBAction func touchCreateSpell(_ sender: Any) {
        presenter.createSpell()
    }
    @IBAction func touchCreateSpellBook(_ sender: Any) {
        presenter.createSpellbook()
    }
}

// MARK: - Input
extension CreateListVC: CreateListInput {
    
}