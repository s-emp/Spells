//
//  FilterBookVC.swift
//  Spells
//
//  Created by Sergey Melnikov on 30/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit

class FilterBookVC: UIViewController {

    // MARK: - Properties
    private var presenter: FilterBookOutput!
    private weak var filterInput: FilterInput!
    
    @IBOutlet private var playersHandbookSwitch: UISwitch!
    @IBOutlet private var xanatharsGuideToEverythingSwitch: UISwitch!
    @IBOutlet private var templeOfElementalEvilSwitch: UISwitch!
    @IBOutlet private var sproutingChaosSwitch: UISwitch!
    @IBOutlet private var homebrewSwitch: UISwitch!
    @IBOutlet private var backButton: UIButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    // MARK: - Life cycle
    required convenience init(filterInput: FilterInput, filter: Filter) {
        self.init()
        self.filterInput = filterInput
        presenter = FilterBookPresenter(self, filter: filter)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        filterInput.changeBooks(presenter.filter.books)
    }
    
    // MARK: - Methods
    @IBAction func touchPlayersHandbook(_ sender: Any) {
        presenter.playersHandbook.toggle()
    }
    
    @IBAction func touchXanatharsGuideToEverything(_ sender: Any) {
        presenter.xanatharsGuideToEverything.toggle()
    }
    
    @IBAction func touchTempleOfElementalEvil(_ sender: Any) {
        presenter.templeOfElementalEvil.toggle()
    }
    
    @IBAction func touchSproutingChaos(_ sender: Any) {
        presenter.sproutingChaos.toggle()
    }
    
    @IBAction func touchHomebrew(_ sender: Any) {
        presenter.homebrew.toggle()
    }
    
    @IBAction func touchBack(_ sender: Any) {
        UIView.animate(withDuration: 0.2, animations: {
            self.view.frame = CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }) { _ in
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
    }
}

// MARK: - Input
extension FilterBookVC: FilterBookInput {
    
}

// MARK: - Prepare
extension FilterBookVC {
    func prepareUI() {
        playersHandbookSwitch.setOn(presenter.playersHandbook, animated: false)
        xanatharsGuideToEverythingSwitch.setOn(presenter.xanatharsGuideToEverything, animated: false)
        templeOfElementalEvilSwitch.setOn(presenter.templeOfElementalEvil, animated: false)
        sproutingChaosSwitch.setOn(presenter.sproutingChaos, animated: false)
        homebrewSwitch.setOn(presenter.homebrew, animated: false)
    }
}
