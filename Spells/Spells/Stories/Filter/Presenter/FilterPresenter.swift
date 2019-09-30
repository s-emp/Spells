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
    var resultCount: Int = 0
    weak var view: FilterInput!
    private let service: SpellService
    var filter: Filter
    var professions: [Profession] { return Profession.allCases }
    
    // MARK: - Methods
    func resetFilter() {
        filter = Filter(levels: [], professions: [], isConcentration: false, isRitual: false, books: [])
        updateResultCount()
    }
    
    func changeSelectedProfessions(_ selected: [Profession]) {
        filter.professions = selected
        updateResultCount()
    }
    
    func changeSelectedLevels(_ selected: [Int]) {
        filter.levels = selected
        updateResultCount()
    }
    
    func changeValueConcentration() {
        filter.isConcentration.toggle()
        updateResultCount()
    }
    
    func changeValueRitual() {
        filter.isRitual.toggle()
        updateResultCount()
    }
    
    func changeBooks(_ selected: [Book]) {
        filter.books = selected
        updateResultCount()
    }
    
    private func updateResultCount() {
        resultCount = filter.apply(service.getSpells()).count
        view.updateUI()
    }
    
    required init(_ view: FilterInput, service: SpellService, filter: Filter) {
        self.view = view
        self.service = service
        self.filter = filter
        resultCount = filter.apply(service.getSpells()).count
    }
}
