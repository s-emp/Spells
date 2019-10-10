//
//  CreateSpellbookVC.swift
//  Spells
//
//  Created by Sergey Melnikov on 01/10/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit

fileprivate let identifier = "cell"

class CreateSpellbookVC: UIViewController {

    // MARK: - Properties
    private var presenter: CreateSpellbookOutput! 
    private weak var menu: TabBarWithPopupMenuInput!
    @IBOutlet private var spellbooksTableView: UITableView!
    
    // MARK: - Life cycle
    required convenience init(_ menu: TabBarWithPopupMenuInput, spell: Spell) {
        self.init()
        self.menu = menu
        presenter = CreateSpellbookPresenter(self, service: SpellService.shared(), spell: spell)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
    }

}

// MARK: - Prepare
extension CreateSpellbookVC {
    private func prepareTableView() {
        spellbooksTableView.register(UINib(nibName: "SpellbookInMenuCell", bundle: nil), forCellReuseIdentifier: identifier)
    }
}

// MARK: - Input
extension CreateSpellbookVC: CreateSpellbookInput {
    func hide() {
        menu.hidePopupMenu()
    }
}

// MARK: - PopupMenuItem
extension CreateSpellbookVC: PopupMenuItem {
    var heightItem: CGFloat {
        let result: CGFloat = presenter.spellbooks.count * 56 + 56 > 300 ? 300 : CGFloat(presenter.spellbooks.count * 56 + 56)
        return result
    }
    
    var viewControllerItem: UIViewController {
        return self
    }
}

// MARK: - UITableViewDataSource
extension CreateSpellbookVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.spellbooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? SpellbookInMenuCell else { return }
        cell.spellbook = presenter.spellbooks[indexPath.row]
    }
}

// MARK: - UITableViewDelegate
extension CreateSpellbookVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.touchItem(indexPath.row)
    }
}
