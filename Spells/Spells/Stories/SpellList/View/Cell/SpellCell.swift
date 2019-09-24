//
//  SpellCell.swift
//  Spells
//
//  Created by Сергей Мельников on 20/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit

class SpellCell: UITableViewCell {

    var spell: Spell! {
        didSet {
            nameLabel.text = spell.name
            levelLabel.text = spell.level == 0 ? "Заговор" : "\(spell.level) уровня"
            schoolView.backgroundColor = UIColor(named: .scholl1)
            schoolLabel.text = spell.school.fullName(.ru)
        }
    }
    
    // MARK: - IBOutlet
    @IBOutlet private var nameLabel: Header2!
    @IBOutlet private var levelLabel: TextTag!
    @IBOutlet private var schoolView: UIView!
    @IBOutlet private var schoolLabel: TextTag!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - IBAction
    @IBAction func touchAddSpellInSpellbook(_ sender: Any) {
    }
    
}
