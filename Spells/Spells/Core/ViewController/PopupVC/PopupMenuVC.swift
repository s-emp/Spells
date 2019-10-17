//
//  PopupMenuVC.swift
//  Spells
//
//  Created by Sergey Melnikov on 19/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit

class PopupMenuVC: UIViewController {
    
    var startRect: CGRect?
    var endRect: CGRect!
    weak var childVC: UIViewController?
    
    private var popupMenu: UIView!
    
    func show(_ parentView: UIView = UIApplication.shared.keyWindow!.rootViewController!.view!) {
        guard let childVC = childVC else { return }
        addChild(childVC)
        view.frame = parentView.bounds
        popupMenu.frame = startRect ?? CGRect(origin: parentView.center, size: CGSize(width: 40, height: 40))
        childVC.view.frame = popupMenu.bounds
        popupMenu.addSubview(childVC.view)
        parentView.addSubview(view)
        UIView.animate(withDuration: 0.2) {
            self.view.alpha = 1
            self.popupMenu.frame = self.endRect
            childVC.view.frame = self.popupMenu.bounds
            childVC.view.layoutIfNeeded()
            self.popupMenu.alpha = 1
        }
    }
    
    func hide(_ parentView: UIView = UIApplication.shared.windows.first!.rootViewController!.view!) {
        UIView.animate(withDuration: 0.2, animations: {
            self.view.alpha = 0
            self.popupMenu.frame = self.startRect ?? CGRect(origin: parentView.center, size: CGSize(width: 40, height: 40))
            self.popupMenu.alpha = 0
        }) { _ in
            self.childVC?.view.removeFromSuperview()
            self.childVC?.removeFromParent()
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
    }
        
    @objc func touchBackground(_ sender:UITapGestureRecognizer){
       hide()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        preparePopupMenu()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        preparePopupMenu()
    }
    
    deinit {
        print("Popupmenu deinit!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.alpha = 0
        view.backgroundColor = UIColor(named: .popupBackground)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let button = UIButton(frame: view.bounds)
        button.addTarget(self, action: #selector(touchBackground(_:)), for: .touchUpInside)
        view.insertSubview(button, at: 0)
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
