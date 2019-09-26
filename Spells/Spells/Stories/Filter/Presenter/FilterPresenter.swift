//
//  FilterPresenter.swift
//  Spells
//
//  Created by Sergey Melnikov on 26/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

class FilterPresenter: FilterOutput {
    // MARK: - Properties
    weak var view: FilterInput!
    private let service: SpellService
    private(set) var filter: Filter
    
    // MARK: - Methods
    func resetFilter() {
        filter = Filter(levels: [], professions: [], isConcentration: false, isRitual: false, books: [])
        view.updateUI()
    }
    
    required init(_ view: FilterInput, service: SpellService, filter: Filter) {
        self.view = view
        self.service = service
        self.filter = filter
    }
}
