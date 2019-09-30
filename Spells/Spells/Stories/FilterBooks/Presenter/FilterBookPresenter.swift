//
//  FilterBookPresenter.swift
//  Spells
//
//  Created by Sergey Melnikov on 30/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import Foundation

class FilterBookPresenter: FilterBookOutput {
    var playersHandbook: Bool {
        willSet { newValue ? filter.books.append(.PHB) : filter.books.removeAll { $0 == .PHB } }
    }
    
    var xanatharsGuideToEverything: Bool{
        willSet { newValue ? filter.books.append(.XGTE) : filter.books.removeAll { $0 == .XGTE } }
    }
    
    var templeOfElementalEvil: Bool{
        willSet { newValue ? filter.books.append(.TOEE) : filter.books.removeAll { $0 == .TOEE } }
    }
    
    var sproutingChaos: Bool{
        willSet { newValue ? filter.books.append(.SCPC) : filter.books.removeAll { $0 == .SCPC } }
    }
    
    var homebrew: Bool{
        willSet { newValue ? filter.books.append(.HB) : filter.books.removeAll { $0 == .HB } }
    }
    
    // MARK: - Properties
    weak var view: FilterBookInput!
    
    private(set) var filter: Filter
    
    // MARK: - Methods
    required init(_ view: FilterBookInput, filter: Filter) {
        self.view = view
        self.filter = filter
        playersHandbook = filter.books.contains(.PHB)
        xanatharsGuideToEverything = filter.books.contains(.XGTE)
        templeOfElementalEvil = filter.books.contains(.TOEE)
        sproutingChaos = filter.books.contains(.SCPC)
        homebrew = filter.books.contains(.HB)
    }
}
