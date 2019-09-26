//
//  FilterVC.swift
//  Spells
//
//  Created by Sergey Melnikov on 25/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit

class FilterVC: UIViewController {

    // MARK: - Properties
    private var presenter: FilterOutput!
    @IBOutlet private var levelViews: [FilterLevelView]!
    @IBOutlet private var professionTags: IOTags!
    @IBOutlet private var professionHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var concentrationSwitch: UISwitch!
    @IBOutlet private var ritualSwitch: UISwitch!
    @IBOutlet private var booksLabel: TextFilter!
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    // MARK: - Lifecycle
    required convenience init(_ filter: Filter?) {
        self.init()
        presenter = FilterPresenter(self, service: SpellService.shared(), filter: filter ?? Filter(levels: [], professions: [], isConcentration: false, isRitual: false, books: []))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if presenter == nil {
            presenter = FilterPresenter(self, service: SpellService.shared(), filter: Filter(levels: [], professions: [], isConcentration: false, isRitual: false, books: []))
        }
        professionTags.protocolDataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(view.bounds)
        prepareProfessionTags()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        prepareProfessionTags()
        print(view.bounds)
    }
    
    // MARK: - Methods
    @IBAction func resetFilters(_ sender: Any) {
        presenter.resetFilter()
        
    }
    
    @IBAction func touchSelectedBooks(_ sender: Any) {
        
    }
    
    @IBAction func touchCloseFilter(_ sender: Any) {
        
    }
}

// MARK: - Input
extension FilterVC: FilterInput {
    func updateUI() {
        let filter = presenter.filter
        levelViews.forEach { filterLevelView in
            filterLevelView.isSelected = filter.levels.first(where: { level -> Bool in
                return String(level) == filterLevelView.title
                }) != nil
        }
        professionTags.indexPathsForSelectedItems?.forEach { professionTags.deselectItem(at: $0, animated: false) }
        for prof in filter.professions {
            guard let row = professionTags.correctDataSource.enumerated().first(where: { $0.element == prof.fullName(Language.systemLanguage) })?.offset else { continue }
            professionTags.selectItem(at: IndexPath(row: row, section: 0), animated: false, scrollPosition: .centeredHorizontally)
        }
        concentrationSwitch.setOn(filter.isConcentration, animated: true)
        ritualSwitch.setOn(filter.isConcentration, animated: true)
    }
}

// MARK: - IOTagsDataSource
extension FilterVC: IOTagsDataSource {
    func components(_ tags: IOTags) -> [CustomStringConvertible] {
        if tags == professionTags {
            return Profession.allCases.map { $0.fullName(Language.systemLanguage) }
        }
        return []
    }
}

// MARK: - Prepare
extension FilterVC {
    private func prepareProfessionTags() {
        professionTags.clipsToBounds = false
        professionTags.prepareSpacingBeetwenCells(view.bounds.width - 32)
        professionTags.reloadData()
        professionHeightConstraint.constant = professionTags.collectionViewLayout.collectionViewContentSize.height
    }
}
