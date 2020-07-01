//
//  CreateListVC.swift
//  Spells
//
//  Created by Sergey Melnikov on 19/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit

class CreateListVC: UIViewController {
    
    private var presenter: CreateListOutput!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = CreateListPresenter(self)
    }

    @IBAction func touchCreateSpell(_ sender: Any) {
        presenter.createSpell()
    }
    @IBAction func touchCreateSpellBook(_ sender: Any) {
        presenter.createSpellbook()
    }
}

// MARK: - Input
extension CreateListVC: CreateListInput {
    func showCreateSpellVC() {
        let storyboard = UIStoryboard(name: "CreateSpell", bundle: nil)
        guard let vc = storyboard.instantiateInitialViewController() else { return }
        vc.modalPresentationStyle = .fullScreen
        TabBarService.shared().tabBar.hidePopupMenuAndShowVC(vc)
    }
    
    func showCreateSpellbookVC() {
        let vc = CreateSpellbookVC()
        vc.modalPresentationStyle = .fullScreen
        TabBarService.shared().tabBar.hidePopupMenuAndShowVC(vc)
    }
}

// MARK: - PopupMenuItem
extension CreateListVC: PopupMenuItem {
    var heightItem: CGFloat { return 120.0 }
    var viewControllerItem: UIViewController { return self }
}
