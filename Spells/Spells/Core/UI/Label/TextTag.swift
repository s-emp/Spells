//
//  TextTag.swift
//  Spells
//
//  Created by Sergey Melnikov on 19/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit

class TextTag: UILabel {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.font = UIFont.systemFont(ofSize: 11, weight: .regular)
    }

}
