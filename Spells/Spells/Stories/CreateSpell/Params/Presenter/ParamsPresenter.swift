//
//  ParamsPresenter.swift
//  Spells
//
//  Created by Sergey Melnikov on 11.10.2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

class ParamsPresenter: ParamsOutput {
    // MARK: - Properties
    weak var view: ParamsInput!
    
    // MARK: - Methods
    required init(_ view: ParamsInput) {
        self.view = view
    }
}
