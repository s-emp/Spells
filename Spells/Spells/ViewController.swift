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
        guard let url = Bundle.main.url(forResource: "Spell", withExtension: "json") else { fatalError("Отсутствует файл Spell.json в Bundle") }
        let spells: [Spell] = try! ViewController.import(url)
        var newSpells = [Spell]()
        for var (index, spell) in spells.enumerated() {
            spell.language = index % 2 == 0 ? .en : .ru
            newSpells.append(spell)
        }
        let finalSpells = newSpells.filter { $0.language == .ru }
        let urlForSave = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//        Spell.save(to: urlForSave, spells: finalSpells)
    }
}
