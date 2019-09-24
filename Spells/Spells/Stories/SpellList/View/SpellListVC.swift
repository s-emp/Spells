//
//  SpellListVC.swift
//  Spells
//
//  Created by Сергей Мельников on 20/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit

class SpellListVC: UIViewController {

    // MARK: - Properties
    private var presenter: SpellListOutput!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SpellListPresenter(self, service: SpellService.shared())
    }
}

// MARK: - Input
extension SpellListVC: SpellListInput {
    
}

// MARK: - TableViewDataSource
extension SpellListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.spells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: - TableViewDelegate
extension SpellListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectItem(indexPath)
    }
}
