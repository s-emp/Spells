//
//  SpellListVC.swift
//  Spells
//
//  Created by Сергей Мельников on 20/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit

fileprivate let identifier = "cell"

class SpellListVC: UIViewController {

    // MARK: - Properties
    private var presenter: SpellListOutput!
    
    @IBOutlet private var spellsTableView: UITableView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SpellListPresenter(self, service: SpellService.shared())
        spellsTableView.register(UINib(nibName: "SpellCell", bundle: nil), forCellReuseIdentifier: identifier)
    }
}

// MARK: - Input
extension SpellListVC: SpellListInput {
    
}

// MARK: - TableViewDataSource
extension SpellListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Count spells: \(presenter.spells.count)")
        return presenter.spells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? SpellCell else { return }
        
        cell.spell = presenter.spells[indexPath.row]
    }
}

// MARK: - TableViewDelegate
extension SpellListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectItem(indexPath)
    }
}
