//
//  AddInSpellbookVC.swift
//  Spells
//
//  Created by Sergey Melnikov on 01/10/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit
import NotificationBannerSwift

fileprivate let identifier = "cell"

class AddInSpellbookVC: UIViewController {

    // MARK: - Properties
    private var presenter: AddInSpellbookOutput!
    private weak var menu: TabBarWithPopupMenuInput!
    @IBOutlet private var spellbooksTableView: UITableView!
    
    // MARK: - Life cycle
    required convenience init(_ menu: TabBarWithPopupMenuInput, spell: Spell) {
        self.init()
        self.menu = menu
        presenter = AddInSpellbookPresenter(self, service: SpellService.shared(), spell: spell)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
    }

}

// MARK: - Prepare
extension AddInSpellbookVC {
    private func prepareTableView() {
        spellbooksTableView.register(UINib(nibName: "SpellbookInMenuCell", bundle: nil), forCellReuseIdentifier: identifier)
    }
}

// MARK: - Input
extension AddInSpellbookVC: AddInSpellbookInput {
    func hide() {
        let banner = StatusBarNotificationBanner(title: "Заклинание успешно добавлено!", style: .success)
        banner.duration = 0.2
        banner.show()
        menu.hidePopupMenu()
    }
}

// MARK: - PopupMenuItem
extension AddInSpellbookVC: PopupMenuItem {
    var heightItem: CGFloat {
        let result: CGFloat = presenter.spellbooks.count * 56 + 56 > 300 ? 300 : CGFloat(presenter.spellbooks.count * 56 + 56)
        return result
    }
    
    var viewControllerItem: UIViewController {
        return self
    }
}

// MARK: - UITableViewDataSource
extension AddInSpellbookVC: UITableViewDataSource {
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
extension AddInSpellbookVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.touchItem(indexPath.row)
    }
}
