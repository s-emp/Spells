//
//  FilterBookPresenter.swift
//  Spells
//
//  Created by Sergey Melnikov on 30/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

class FilterBookPresenter: FilterBookOutput {
    // MARK: - Properties
    weak var view: FilterBookInput!
    
    // MARK: - Methods
    required init(_ view: FilterBookInput) {
        self.view = view
    }
}
