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
    
    @IBOutlet private var headerView: UIView!
    @IBOutlet private var headerLabel: Header1!
    @IBOutlet private var largeHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var shortHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var filterButton: UIButton!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet private var spellsTableView: UITableView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareNotifications()
        filterButton.tintColor = UIColor(named: .background)
        presenter = SpellListPresenter(self, service: SpellService.shared())
        spellsTableView.register(UINib(nibName: "SpellCell", bundle: nil), forCellReuseIdentifier: identifier)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareHeaderView()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Methods
    @IBAction func touchFilter(_ sender: Any) {
        searchTextField.resignFirstResponder()
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            spellsTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        
    }
}

// MARK: - Prepare
extension SpellListVC {
    private func prepareNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func prepareHeaderView() {
        let layer0 = CAGradientLayer()
        layer0.colors = [
          UIColor(red: 0.23, green: 0.47, blue: 0.6, alpha: 1).cgColor,
          UIColor(red: 0.44, green: 0.69, blue: 0.81, alpha: 1).cgColor
        ]
        layer0.locations = [0, 1]
        layer0.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer0.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0.96, b: 0.78, c: -0.78, d: 2.79, tx: 0.41, ty: -1.37))
        layer0.bounds = view.bounds.insetBy(dx: -0.5*view.bounds.size.width, dy: -0.5*view.bounds.size.height)
        layer0.position = view.center
        headerView.layer.insertSublayer(layer0, at: 0)
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
