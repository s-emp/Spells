//
//  SearchTextField.swift
//  Spells
//
//  Created by Sergey Melnikov on 24/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit

class SearchTextField: UITextField {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        borderStyle = .none
        layer.cornerRadius = rect.height / 2
        layer.backgroundColor = UIColor(named: .searchTextField)?.cgColor
        clipsToBounds = true
    }
}
