//
//  SpellCell.swift
//  Spells
//
//  Created by Сергей Мельников on 20/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit

class SpellCell: UITableViewCell {
    // MARK: - Properties
    var spell: Spell! {
        didSet {
            nameLabel.text = spell.name
            levelLabel.text = spell.level == 0 ? "Заговор" : "\(spell.level) уровня"
            schoolView.backgroundColor = UIColor(named: UIColor.Palette(rawValue: spell.school.rawValue)!)
            schoolLabel.text = spell.school.fullName(Language.systemLanguage)
        }
    }
    
    var addSpellbookButtonHidden: Bool {
        get { return addSpellbookButton.isHidden }
        set { addSpellbookButton.isHidden = newValue }
    }
    
    @IBOutlet private var nameLabel: Header2!
    @IBOutlet private var levelLabel: TextTag!
    @IBOutlet private var schoolView: UIView!
    @IBOutlet private var schoolLabel: TextTag!
    @IBOutlet private var addSpellbookButton: UIButton!
    
    
    // MARK: - Methods
    @IBAction func touchAddSpellInSpellbook(_ sender: Any) {
        let tabBar = TabBarService.shared().tabBar
        let vc = AddInSpellbookVC(tabBar, spell: spell)
        tabBar.showPopupMenu(with: vc)
//        let vc = AddInSpellbookVC(tb.popupVC, spell: spell)
//        tb.showInMenu(vc)
    }
}
