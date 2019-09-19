//
//  PopupMenuVC.swift
//  Spells
//
//  Created by Sergey Melnikov on 19/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit

class PopupMenuVC: UIViewController {
    
    var rootView: UIView!
    var startRect: CGRect?
    var endRect: CGRect!
    var titlePopupMenu: String?
    
    var popupMenu: UIView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        preparePopupMenu()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        preparePopupMenu()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.alpha = 0
        view.backgroundColor = UIColor(named: .popupBackground)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

// MARK: - Prepare
extension PopupMenuVC {
    fileprivate func preparePopupMenu() {
        popupMenu = UIView(frame: .zero)
        popupMenu.backgroundColor = UIColor(named: .background)
        popupMenu.layer.cornerRadius = 20
    }
}
