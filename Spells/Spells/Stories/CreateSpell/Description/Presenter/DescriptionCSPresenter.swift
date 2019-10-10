//
//  DescriptionCSPresenter.swift
//  Spells
//
//  Created by Sergey Melnikov on 10.10.2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

class DescriptionCSPresenter: DescriptionCSOutput {
    // MARK: - Properties
    weak var view: DescriptionCSInput!
    
    // MARK: - Methods
    required init(_ view: DescriptionCSInput) {
        self.view = view
    }
}
