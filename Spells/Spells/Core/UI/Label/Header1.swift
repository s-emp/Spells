//
//  Header1.swift
//  DnDSpells
//
//  Created by Сергей Мельников on 13/09/2019.
//  Copyright © 2019 Сергей Мельников. All rights reserved.
//

import UIKit

class Header1: UILabel {
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.font = UIFont.systemFont(ofSize: 34, weight: .bold)
    }
}

