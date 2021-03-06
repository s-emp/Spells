//
//  IOTagCell.swift
//  instore-osago
//
//  Created by Сергей Мельников on 25.10.2018.
//  Copyright © 2018 SL-Tech. All rights reserved.
//

import UIKit

class IOTagCell: UICollectionViewCell {

    var title: String = "" {
        didSet {
            titleLabel.text = title
            mainView.isHidden = title.isEmpty
        }
    }
    
    override var isSelected: Bool {
        didSet {
            changeBackground()
        }
    }
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet var mainView: UIView!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        clipsToBounds = false
        prepareShadow()
        changeBackground()
    }
    
    fileprivate func changeBackground() {
        if isSelected {
            mainView.layer.shadowOpacity = 0.0
            mainView.backgroundColor = UIColor(named: .plusBackground)
        } else {
            mainView.layer.shadowOpacity = 0.1
            mainView.backgroundColor = UIColor(named: .background)
        }
    }
    
    fileprivate func prepareShadow() {
        mainView.layer.shadowColor = UIColor.black.cgColor
        mainView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        mainView.layer.shadowRadius = 8
    }
}
