//
//  TabBarWithPopupMenu.swift
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

class TabBarWithPopupMenu: UITabBarController {

    // MARK: - Properties
    private var backgroundImageView: UIImageView!
    private var plusButton: PlusButton!
    private var menuList: UIView!
    private var popupVC: PopupMenuVC!
    private var plusButtonForPopupMenu: PlusButton!
    private var presenter: TabBarWithPopupMenuOutput!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = TabBarWithPopupMenuPresenter(self)
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
    
    // MARK: - Methods
    
    @objc private func touchShowPopupMenu() {
        showPopupMenu(with: CreateListVC())
    }
    
    @objc private func touchHidePopupMenu() {
        hidePopupMenu()
    }
}

// MARK: - Prepare
extension TabBarWithPopupMenu {
    fileprivate func prepareTabBarItems() {
        var imageEdgeTop = (UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 7.0) / 2
        imageEdgeTop = imageEdgeTop == 0.0 ? 7.0 : imageEdgeTop
        
        let firstVC = SpellListVC()
        let firstItem = UITabBarItem(title: nil, image: UIImage(named: listImage), selectedImage: UIImage(named: selectedListImage))
        firstItem.imageInsets = UIEdgeInsets(top: imageEdgeTop, left: -10, bottom: -(imageEdgeTop), right: 10)
        firstVC.tabBarItem = firstItem
        
        let twoVC = SpellbookListVC()
        let twoItem = UITabBarItem(title: nil, image: UIImage(named: spellBookImage), selectedImage: UIImage(named: selectedSpellBookImage))
        twoItem.imageInsets = UIEdgeInsets(top: imageEdgeTop, left: 10, bottom: -(imageEdgeTop), right: -10)
        twoVC.tabBarItem = twoItem
        
        viewControllers = [firstVC, twoVC]
    }
    
    fileprivate func prepareButton(_ heightButton: CGFloat, _ heightTabBar: CGFloat) {
        guard plusButton == nil else { return }
        plusButton = PlusButton(frame: CGRect(x: tabBar.center.x - heightButton / 2, y: -(heightButton / 2 - (10 * heightTabBar / 93)), width: heightButton, height: heightButton))
        plusButton.addTarget(self, action: #selector(touchShowPopupMenu), for: .touchUpInside)
    }
    
    fileprivate func prepareTabBar() {
        let window = UIApplication.shared.windows.first
        let heightTabBar = tabBar.bounds.height + (window?.safeAreaInsets.bottom ?? 0.0)
        let baseButtonWidth: CGFloat = 56
        let baseTabBarWidth: CGFloat = 375
        let heightButton = baseButtonWidth * tabBar.bounds.width / baseTabBarWidth
        prepareButton(heightButton, heightTabBar)
        
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
        popupVC.childVC = nil
        popupVC.startRect = tabBar.convert(plusButton.frame, to: nil)
        popupVC.endRect = CGRect(x: baseMargin, y: popupVC.startRect!.origin.y - 16 - heightPopupMenu, width: rootView.bounds.width - baseMargin * 2, height: heightPopupMenu)
    }
}

// MARK: - Input
extension TabBarWithPopupMenu: TabBarWithPopupMenuInput {
    
    func hidePopupMenuAndShowVC(_ vc: UIViewController) {
        hidePopupMenu()
        present(vc, animated: true)
    }
    
    func hidePopupMenu() {
        popupVC.hide()
        plusButtonForPopupMenu.removeTarget(self, action: nil, for: .touchUpInside)
        plusButtonForPopupMenu.removeFromSuperview()
        plusButtonForPopupMenu = nil
        plusButton.setState(.rolledUp, animated: true)
    }
    
    func showPopupMenu(with item: PopupMenuItem) {
        plusButtonForPopupMenu = PlusButton(frame: tabBar.convert(plusButton.frame, to: nil))
        plusButtonForPopupMenu.addTarget(self, action: #selector(touchHidePopupMenu), for: .touchUpInside)
        popupVC.view.addSubview(plusButtonForPopupMenu)
        popupVC.childVC = item.viewControllerItem
        popupVC.endRect = CGRect(x: popupVC.endRect.origin.x, y: popupVC.startRect!.origin.y - 16 - item.heightItem, width: popupVC.endRect.width, height: item.heightItem)
        plusButton.setState(.disclosed, animated: true)
        plusButtonForPopupMenu.setState(.disclosed, animated: true)
        addChild(popupVC)
        popupVC.show()
    }
}
