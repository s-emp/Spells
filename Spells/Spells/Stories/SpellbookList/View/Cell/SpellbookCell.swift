//
//  SpellbookCell.swift
//  Spells
//
//  Created by Sergey Melnikov on 01/10/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit

class SpellbookCell: UITableViewCell {

    var spellbook: Spellbook! {
        didSet {
            nameSpellbookLabel.text = spellbook.name
            let countSpell = spellbook.spells.count
            countSpellsLabel.text = "\(countSpell) \(countSpell.declension(["заклинание", "заклинания", "заклинаний"]))"
            likeImageView.isHidden = spellbook.name != Spellbook.favorites
        }
    }
    
    @IBOutlet private var nameSpellbookLabel: Header2!
    @IBOutlet private var countSpellsLabel: Text2!
    @IBOutlet private var likeImageView: UIImageView!
}
