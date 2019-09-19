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
    private var addButton: UIButton!
    private var menuList: UIView!
    
    fileprivate func prepareTabBarItems() {
        var imageEdgeTop = (UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 7.0) / 2
        imageEdgeTop = imageEdgeTop == 0.0 ? 7.0 : imageEdgeTop
        
        let firstVC = UIViewController()
        let firstItem = UITabBarItem(title: nil, image: UIImage(named: listImage), selectedImage: UIImage(named: selectedListImage))
        firstItem.imageInsets = UIEdgeInsets(top: imageEdgeTop, left: -10, bottom: -(imageEdgeTop), right: 10)
        firstVC.tabBarItem = firstItem
        
        let twoVC = UIViewController()
        let twoItem = UITabBarItem(title: nil, image: UIImage(named: spellBookImage), selectedImage: UIImage(named: selectedSpellBookImage))
        twoItem.imageInsets = UIEdgeInsets(top: imageEdgeTop, left: 10, bottom: -(imageEdgeTop), right: -10)
        twoVC.tabBarItem = twoItem
        
        viewControllers = [firstVC, twoVC]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTabBarItems()
        backgroundImageView = UIImageView(image: UIImage(named: "backgroundTabBar"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let window = UIApplication.shared.windows.first
        let heightTabBar = tabBar.bounds.height + (window?.safeAreaInsets.bottom ?? 0.0)
        let baseButtonWidth: CGFloat = 56
        let baseTabBarWidth: CGFloat = 375
        let heightButton = baseButtonWidth * tabBar.bounds.width / baseTabBarWidth
        addButton = UIButton(frame: CGRect(x: tabBar.center.x - heightButton / 2, y: -(heightButton / 2 - (10 * heightTabBar / 93)), width: heightButton, height: heightButton))
        
        backgroundImageView.frame = CGRect(x: tabBar.bounds.origin.x, y: tabBar.bounds.origin.y, width: tabBar.bounds.width, height: heightTabBar)
        
        tabBar.addSubview(backgroundImageView)
        tabBar.sendSubviewToBack(backgroundImageView)
        tabBar.addSubview(addButton)
    }
}
