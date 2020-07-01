//
//  NextButton.swift
//  Spells
//
//  Created by Sergey Melnikov on 10.10.2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit

class NextButton: UIButton {
    
    // MARK: - Properties
    override var isEnabled: Bool {
        willSet {
            backgroundColor = newValue ? UIColor(named: .buttonEnabled) : UIColor(named: .buttonDisabled)
        }
    }
    
    // MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepare()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepare()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = 4
    }
    
    // MARK: - Prepare
    private func prepare() {
        setTitle("Далее", for: .normal)
        clipsToBounds = true
        
        let attEnabled = NSAttributedString(string: "Далее", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor(named: .buttonTitleEnabled)])
        let attDisabled = NSAttributedString(string: "Далее", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor(named: .buttonTitleDisabled)])
        
        setAttributedTitle(attEnabled, for: .normal)
        setAttributedTitle(attDisabled, for: .disabled)
        
        backgroundColor = isEnabled ? UIColor(named: .buttonEnabled) : UIColor(named: .buttonDisabled)
    }
}
