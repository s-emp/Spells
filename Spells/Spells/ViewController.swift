//
//  ViewController.swift
//  Spells
//
//  Created by Sergey Melnikov on 19/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Imported, Exported {

    override func viewDidLoad() {
        super.viewDidLoad()
        let service = SpellService.shared()
        let spellsRealm = service.realm.objects(SpellRealm.self)
        let spells = Array(spellsRealm.map { Spell.transform($0) })
        print("Spell in DB: \(spellsRealm.count)")
        print("Spell in JSON: \(spells.count)")
    }
}
