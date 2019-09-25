//
//  UIView+Radius.swift
//  Spells
//
//  Created by Sergey Melnikov on 24/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable var radius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
}
