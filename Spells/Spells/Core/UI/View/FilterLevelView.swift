//
//  FilterLevelView.swift
//  Spells
//
//  Created by Sergey Melnikov on 25/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit

protocol FilterLevelViewDelegate: AnyObject {
    func tap()
}

class FilterLevelView: UIView {
    
    // MARK: - Properties
    weak var delegate: FilterLevelViewDelegate?
    private var titleLabel: Text!
    private var shadowLayer: CAShapeLayer!
    private var tapEngine = UISelectionFeedbackGenerator()
    @IBInspectable var isSelected: Bool = false {
        didSet {
            guard let shadowLayer = shadowLayer else { return }
            if isSelected {
                shadowLayer.removeFromSuperlayer()
                clipsToBounds = true
                backgroundColor = UIColor(named: .plusBackground)
            } else {
                layer.insertSublayer(shadowLayer, at: 0)
                clipsToBounds = false
                backgroundColor = UIColor(named: .background)
            }
        }
    }
    @IBInspectable var title: String = "" {
        didSet { titleLabel?.text = title }
    }
    
    // MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepareUI()
    }
    
    // MARK: - Methods
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        titleLabel.frame = bounds
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 15).cgPath
            shadowLayer.fillColor = UIColor.white.cgColor
            shadowLayer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 1.0, height: 1.0)
            shadowLayer.shadowOpacity = 0.1
            shadowLayer.shadowRadius = 8
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
    
    func prepareUI() {
        titleLabel = Text()
        titleLabel.text = title
        titleLabel.textColor = UIColor(named: .text)
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(checkAction(sender:))))
    }
    
    @objc func checkAction(sender : UITapGestureRecognizer) {
        isSelected.toggle()
        delegate?.tap()
        tapEngine.prepare()
        tapEngine.selectionChanged()
    }
}
