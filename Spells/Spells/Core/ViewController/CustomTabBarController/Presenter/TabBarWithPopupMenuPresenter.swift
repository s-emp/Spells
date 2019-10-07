//
//  TabBarWithPopupMenuPresenter.swift
//  Spells
//
//  Created by Sergey Melnikov on 01/10/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

class TabBarWithPopupMenuPresenter: TabBarWithPopupMenuOutput {
    // MARK: - Properties
    weak var view: TabBarWithPopupMenuInput!
    
    // MARK: - Methods
    required init(_ view: TabBarWithPopupMenuInput) {
        self.view = view
    }
}
