//
//  PlusButton.swift
//  Spells
//
//  Created by Sergey Melnikov on 19/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit

enum PlusButtonState {
    case disclosed
    case rolledUp
}

fileprivate let imageName = "plusButton"
final class PlusButton: UIButton {

    var addState: PlusButtonState = .rolledUp
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareUI()
    }
    
    private func prepareUI() {
        setImage(UIImage(named: imageName), for: .normal)
        layer.cornerRadius = bounds.height / 2
        imageView?.tintColor = UIColor.white
        backgroundColor = UIColor(named: .plusBackground)
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 10.0
        layer.masksToBounds = false
    }
    
    func setState(_ state: PlusButtonState, animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.25) {
                self.changeState(state)
            }
        } else {
            changeState(state)
        }
    }

    private func changeState(_ state: PlusButtonState) {
        switch state {
        case .disclosed:
            transform = CGAffineTransform(rotationAngle: 0)
            backgroundColor = UIColor(named: .plusBackground)
            imageView?.tintColor = UIColor.white
        case .rolledUp:
            transform = CGAffineTransform(rotationAngle: .pi / 4)
            backgroundColor = UIColor.white
            imageView?.tintColor = UIColor(named: .icon)
        }
    }
}
