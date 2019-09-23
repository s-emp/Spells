//
//  ViewController.swift
//  Spells
//
//  Created by Sergey Melnikov on 19/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension ViewController {
    fileprivate func transformSpells() {
        let service = SpellService.shared()
        let allObjects = service.getAllSpell()
        var newSpells: [SpellN] = []
        allObjects.forEach { spell in
            
        }
    }
}
