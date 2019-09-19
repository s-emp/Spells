//
//  PopupMenuVC.swift
//  Spells
//
//  Created by Sergey Melnikov on 19/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit

class PopupMenuVC: UIViewController {
    
    private let rootView: UIView = UIApplication.shared.windows.first!.rootViewController!.view!
    
    var startRect: CGRect?
    var endRect: CGRect!
    var childVC: UIViewController?
    
    private var popupMenu: UIView!
    
    func show() {
        guard let childVC = childVC else { return }
        addChild(childVC)
        view.frame = rootView.bounds
        popupMenu.frame = startRect ?? CGRect(origin: rootView.center, size: CGSize(width: 40, height: 40))
        childVC.view.frame = popupMenu.bounds
        popupMenu.addSubview(childVC.view)
        rootView.addSubview(view)
        UIView.animate(withDuration: 0.2) {
            self.view.alpha = 1
            self.popupMenu.frame = self.endRect
            childVC.view.frame = self.popupMenu.bounds
            childVC.view.layoutIfNeeded()
            self.popupMenu.alpha = 1
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 0.2, animations: {
            self.view.alpha = 0
            self.popupMenu.frame = self.startRect ?? .zero
            self.popupMenu.alpha = 0
            self.childVC!.view.layoutIfNeeded()
        })
    }
    
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
}

// MARK: - Prepare
extension PopupMenuVC {
    fileprivate func preparePopupMenu() {
        popupMenu = UIView(frame: .zero)
        popupMenu.clipsToBounds = true
        popupMenu.alpha = 0
        popupMenu.backgroundColor = UIColor(named: .background)
        popupMenu.layer.cornerRadius = 20
        view.addSubview(popupMenu)
    }
}
