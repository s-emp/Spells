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
    var spellList: SpellListInput!
    private var presenter: FilterOutput!
    @IBOutlet private var levelViews: [FilterLevelView]!
    @IBOutlet private var professionTags: IOTags!
    @IBOutlet private var professionHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var concentrationSwitch: UISwitch!
    @IBOutlet private var ritualSwitch: UISwitch!
    @IBOutlet private var booksLabel: TextFilter!
    @IBOutlet private var successButton: UIButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    // MARK: - Lifecycle
    required convenience init(_ filter: Filter, spellList: SpellListInput) {
        self.init()
        self.spellList = spellList
        presenter = FilterPresenter(self, service: SpellService.shared(), filter: filter)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if presenter == nil {
            presenter = FilterPresenter(self, service: SpellService.shared(), filter: Filter(levels: [], professions: [], isConcentration: false, isRitual: false, books: []))
        }
        
        professionTags.protocolDataSource = self
        levelViews.forEach { $0.delegate = self }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareProfessionTags()
        updateUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        prepareProfessionTags()
        updateUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        spellList.applyFilter(presenter.filter)
    }
    
    // MARK: - Methods
    @IBAction func resetFilters(_ sender: Any) {
        presenter.resetFilter()
        
    }
    
    @IBAction func touchConcentration(_ sender: Any) {
        presenter.changeValueConcentration()
    }
    
    @IBAction func touchRitual(_ sender: Any) {
        presenter.changeValueRitual()
    }
    
    @IBAction func touchSelectedBooks(_ sender: Any) {
        updateUI()
    }
    
    @IBAction func touchCloseFilter(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Input
extension FilterVC: FilterInput {
    func updateUI() {
        if presenter.resultCount > 0 {
            successButton.isEnabled = true
            successButton.backgroundColor = UIColor(named: .plusBackground)
            successButton.setTitle("Показать \(presenter.resultCount) \(presenter.resultCount.declension(["результат", "рузультата", "результатов"]))", for: .normal)
        } else {
            successButton.isEnabled = false
            successButton.backgroundColor = UIColor(named: .plusBackgroundDisabled)
        }
        let filter = presenter.filter
        levelViews.forEach { filterLevelView in
            filterLevelView.isSelected = filter.levels.first(where: { String($0) == filterLevelView.title }) != nil
        }
        professionTags.indexPathsForSelectedItems?.forEach { professionTags.deselectItem(at: $0, animated: false) }
        for prof in filter.professions {
            guard let row = professionTags.correctDataSource.enumerated().first(where: { $0.element == prof.fullName(Language.systemLanguage) })?.offset else { continue }
            professionTags.selectItem(at: IndexPath(row: row, section: 0), animated: false, scrollPosition: .centeredHorizontally)
        }
        concentrationSwitch.setOn(filter.isConcentration, animated: true)
        ritualSwitch.setOn(filter.isRitual, animated: true)
    }
}

// MARK: - IOTagsDataSource
extension FilterVC: IOTagsDataSource {
    func didSelectedItem(_ index: IndexPath) {
        guard let selectedIndex = professionTags.indexPathsForSelectedItems else {
            presenter.changeSelectedProfessions([])
            return
        }
        let professions = selectedIndex
            .map { professionTags.cellForItem(at: $0) as? IOTagCell }
            .compactMap { $0 }
            .map { cell in Profession.allCases.first(where: { $0.fullName(Language.systemLanguage) == cell.title }) }
            .compactMap { $0 }
        presenter.changeSelectedProfessions(professions)
    }
    
    func didDeselectedItem(_ index: IndexPath) {
        presenter.changeSelectedProfessions(professionTags.indexPathsForSelectedItems?.map({ presenter.professions[$0.row] }) ?? [] )
    }
    
    func components(_ tags: IOTags) -> [CustomStringConvertible] {
        return presenter.professions.map { $0.fullName(Language.systemLanguage) }
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

extension FilterVC: FilterLevelViewDelegate {
    func tap() {
        presenter.changeSelectedLevels(levelViews.filter { $0.isSelected }.map { Int($0.title)! })
    }
}
