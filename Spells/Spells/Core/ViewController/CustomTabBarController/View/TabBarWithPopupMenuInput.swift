//
//  TabBarWithPopupMenuInput.swift
//  Spells
//
//  Created by Sergey Melnikov on 01/10/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit

protocol PopupMenuItem {
    var heightItem: CGFloat { get }
    var viewControllerItem: UIViewController { get }
}

protocol TabBarWithPopupMenuInput: AnyObject {
    
    func hidePopupMenuAndShowVC(_ vc: UIViewController)
    func hidePopupMenu()
    func showPopupMenu(with item: PopupMenuItem)
}
