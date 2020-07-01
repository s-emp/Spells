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
        let imageView = UIImageView(image: UIImage(named: "search")!)
        imageView.contentMode = .center
        imageView.frame = CGRect(x: 5, y: 0, width: 22, height: frame.height)
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: frame.height))
        leftView!.addSubview(imageView)
        leftViewMode = .always
        clipsToBounds = true
    }
}
