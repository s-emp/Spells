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
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alertConstroller = UIAlertController(title: "Удаление заклинания", message: "Подтвердите удаление.", preferredStyle: .actionSheet)
            let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
                let notification = UINotificationFeedbackGenerator()
                notification.prepare()
                notification.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.success)
                self.presenter.remove(spellInBookspell: self.presenter.spellbook.spells[indexPath.row])
                self.spellsTableView.deleteRows(at: [indexPath], with: .automatic)
            }
            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            alertConstroller.addAction(deleteAction)
            alertConstroller.addAction(cancelAction)
            present(alertConstroller, animated: true, completion: nil)
        }
    }

}

// MARK: - TableViewDelegate
extension SpellbookVC: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        SPStorkController.scrollViewDidScroll(scrollView)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SpellVC(presenter.spellbook.spells[indexPath.row])
        vc.addSpellbookButtonHidden = true
        vc.likeButtonHidden = true
        let transitionDelegate = SPStorkTransitioningDelegate.default
        vc.transitioningDelegate = transitionDelegate
        vc.modalPresentationStyle = .custom
        vc.modalPresentationCapturesStatusBarAppearance = true
        self.present(vc, animated: true, completion: nil)
    }
}
