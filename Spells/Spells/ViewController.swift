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
        let url = URL(string: "file:///Users/melnikov/Developer/HomeProject/Spells/Spells/Spells/Core/Service/Spells/Resources/Spell.json")!
        let spells: [Spell] = try! ViewController.import(url)
        print("Success")
    }
}
