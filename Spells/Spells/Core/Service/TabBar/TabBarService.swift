//
//  TabBarService.swift
//  Spells
//
//  Created by Sergey Melnikov on 01/10/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit

class TabBarService {
    var tabBar: TabBarWithPopupMenuInput
    
    
    private init() {
        tabBar = UIApplication.shared.windows[0].rootViewController as! TabBarWithPopupMenu
    }
    
    private static var tabBar: TabBarService?
    static func shared() -> TabBarService {
        if tabBar == nil {
            tabBar = TabBarService()
        }
        return tabBar!
    }
}
