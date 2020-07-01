//
//  SpellbookInMenuCell.swift
//  Spells
//
//  Created by Sergey Melnikov on 01/10/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit

class SpellbookInMenuCell: UITableViewCell {

    var spellbook: Spellbook! {
        didSet { nameLabel?.text = spellbook.name }
    }
    @IBOutlet private var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
