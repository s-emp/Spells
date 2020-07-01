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
//        guard let url = Bundle.main.url(forResource: "Spell", withExtension: "json") else { fatalError("Отсутствует файл Spell.json в Bundle") }
//        let spells: [Spell] = try! ViewController.import(url)
//        var newSpells = [Spell]()
//        for var (index, spell) in spells.enumerated() {
//            spell.language = index % 2 == 0 ? .en : .ru
//            newSpells.append(spell)
//        }
//        let urlForNew = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first!.appendingPathComponent("Spell.json")
//        try! ViewController.export(urlForNew, objects: newSpells)
//        print("Success URL:\(urlForNew.absoluteString)")
    }
}
