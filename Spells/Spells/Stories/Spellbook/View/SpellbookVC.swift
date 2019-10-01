//
//  SpellbookVC.swift
//  Spells
//
//  Created by Sergey Melnikov on 01/10/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit
import SPStorkController

fileprivate let identifier = "cell"

class SpellbookVC: UIViewController {

    // MARK: - Properties
    private var presenter: SpellbookOutput!
    @IBOutlet private var nameSpellbookLabel: Header1!
    @IBOutlet private var spellsTableView: UITableView!
    
    // MARK: - Life cycle
    required convenience init(_ spellbook: Spellbook) {
        self.init()
        presenter = SpellbookPresenter(self, service: SpellService.shared(), spellbook: spellbook)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        nameSpellbookLabel.text = presenter.spellbook.name
    }
    
    // MARK: - Methods
    
    
}

// MARK: - Prepare
extension SpellbookVC {
    private func prepareTableView() {
        spellsTableView.register(UINib(nibName: "SpellCell", bundle: nil), forCellReuseIdentifier: identifier)
        spellsTableView.tableFooterView = UIView()
    }
}

// MARK: - Input
extension SpellbookVC: SpellbookInput {
    
}

// MARK: - TableViewDataSource
extension SpellbookVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.spellbook.spells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? SpellCell else { return }
        cell.addSpellbookButtonHidden = true
        cell.spell = presenter.spellbook.spells[indexPath.row]
    }

}

// MARK: - TableViewDelegate
extension SpellbookVC: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        SPStorkController.scrollViewDidScroll(scrollView)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SpellVC()
        vc.addSpellbookButtonHidden = true
        vc.likeButtonHidden = true
        vc.spell = presenter.spellbook.spells[indexPath.row]
        let transitionDelegate = SPStorkTransitioningDelegate()
        transitionDelegate.hapticMoments = []
        transitionDelegate.showCloseButton = false
        vc.transitioningDelegate = transitionDelegate
        vc.modalPresentationStyle = .custom
        vc.modalPresentationCapturesStatusBarAppearance = true
        self.present(vc, animated: true, completion: nil)
    }
}
