//
//  CustomTBC.swift
//  Spells
//
//  Created by Sergey Melnikov on 19/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit

fileprivate let listImage = "listTB"
fileprivate let selectedListImage = "listTBS"
fileprivate let spellBookImage = "spellBookTB"
fileprivate let selectedSpellBookImage = "spellBookTBS"

class CustomTBC: UITabBarController {

    private var backgroundImageView: UIImageView!
    private var plusButton: PlusButton!
    private var menuList: UIView!
    private var popupVC: PopupMenuVC!
    private var plusButtonForPopupMenu: PlusButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTabBarItems()
        backgroundImageView = UIImageView(image: UIImage(named: "backgroundTabBar"))
        backgroundImageView.backgroundColor = UIColor(named: .background)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareTabBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        preparePopupMenu()
    }
    
    @objc func touchShowPopupMenu() {
        plusButton.setState(.disclosed, animated: true)
        plusButtonForPopupMenu.setState(.disclosed, animated: true)
        addChild(popupVC)
        popupVC.show()
        
    }
    
    @objc func hidePopupMenu() {
        popupVC.hide()
        plusButtonForPopupMenu.setState(.rolledUp, animated: true)
        plusButton.setState(.rolledUp, animated: true)
    }
}

// MARK: - Prepare
extension CustomTBC {
    fileprivate func prepareTabBarItems() {
        var imageEdgeTop = (UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 7.0) / 2
        imageEdgeTop = imageEdgeTop == 0.0 ? 7.0 : imageEdgeTop
        
        let firstVC = ViewController()
        let firstItem = UITabBarItem(title: nil, image: UIImage(named: listImage), selectedImage: UIImage(named: selectedListImage))
        firstItem.imageInsets = UIEdgeInsets(top: imageEdgeTop, left: -10, bottom: -(imageEdgeTop), right: 10)
        firstVC.tabBarItem = firstItem
        
        let twoVC = ViewController()
        let twoItem = UITabBarItem(title: nil, image: UIImage(named: spellBookImage), selectedImage: UIImage(named: selectedSpellBookImage))
        twoItem.imageInsets = UIEdgeInsets(top: imageEdgeTop, left: 10, bottom: -(imageEdgeTop), right: -10)
        twoVC.tabBarItem = twoItem
        
        viewControllers = [firstVC, twoVC]
    }
    
    fileprivate func prepareTabBar() {
        let window = UIApplication.shared.windows.first
        let heightTabBar = tabBar.bounds.height + (window?.safeAreaInsets.bottom ?? 0.0)
        let baseButtonWidth: CGFloat = 56
        let baseTabBarWidth: CGFloat = 375
        let heightButton = baseButtonWidth * tabBar.bounds.width / baseTabBarWidth
        plusButton = PlusButton(frame: CGRect(x: tabBar.center.x - heightButton / 2, y: -(heightButton / 2 - (10 * heightTabBar / 93)), width: heightButton, height: heightButton))
        plusButton.addTarget(self, action: #selector(touchShowPopupMenu), for: .touchUpInside)
        
        backgroundImageView.frame = CGRect(x: tabBar.bounds.origin.x, y: tabBar.bounds.origin.y, width: tabBar.bounds.width, height: heightTabBar)
        
        tabBar.shadowImage = UIImage()
        if #available(iOS 13.0, *) {
            let appearance = self.tabBar.standardAppearance.copy()
            appearance.shadowImage = UIImage()
            appearance.shadowColor = UIColor(named: .background)
            tabBar.standardAppearance = appearance
        }
        tabBar.backgroundImage = UIImage()
        tabBar.backgroundColor = UIColor(named: .background)
        
        tabBar.addSubview(backgroundImageView)
        tabBar.sendSubviewToBack(backgroundImageView)
        tabBar.addSubview(plusButton)
    }
    
    fileprivate func preparePopupMenu() {
        let rootView = UIApplication.shared.windows.first!.rootViewController!.view!
        let baseMargin: CGFloat = 20
        let heightPopupMenu: CGFloat = 120
        popupVC = PopupMenuVC()
        popupVC.childVC = CreateListVC()
        popupVC.startRect = tabBar.convert(plusButton.frame, to: nil)
        popupVC.endRect = CGRect(x: baseMargin, y: popupVC.startRect!.origin.y - 16 - heightPopupMenu, width: rootView.bounds.width - baseMargin * 2, height: heightPopupMenu)
        
        plusButtonForPopupMenu = PlusButton(frame: tabBar.convert(plusButton.frame, to: nil))
        plusButtonForPopupMenu.addTarget(self, action: #selector(hidePopupMenu), for: .touchUpInside)
        popupVC.view.addSubview(plusButtonForPopupMenu)
    }
}
