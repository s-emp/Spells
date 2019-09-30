//
//  SpellListVC.swift
//  Spells
//
//  Created by Сергей Мельников on 20/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit
import SPStorkController

fileprivate let identifier = "cell"

class SpellListVC: UIViewController {

    // MARK: - Properties
    private var presenter: SpellListOutput!
    
    @IBOutlet private var headerView: UIView!
    @IBOutlet private var headerLabel: Header1!
    @IBOutlet private var filterButton: UIButton!
    @IBOutlet private var searchTextField: UITextField!
    @IBOutlet private var spellsTableView: UITableView!
    
    @IBOutlet private var headerLabelSafeAreaTopConstraint: NSLayoutConstraint!
    @IBOutlet private var headerLabelTopConstraint: NSLayoutConstraint!
    
    @IBOutlet private var filterButtonSafeAreaTopConstraint: NSLayoutConstraint!
    @IBOutlet private var filterButtonTopConstraint: NSLayoutConstraint!
    
    @IBOutlet private var textFieldRightConstraint: NSLayoutConstraint!
    @IBOutlet private var cancelButtonRightConstraint: NSLayoutConstraint!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareNotifications()
        filterButton.tintColor = UIColor(named: .background)
        presenter = SpellListPresenter(self, service: SpellService.shared(), filter: Filter(levels: [], professions: [], isConcentration: false, isRitual: false, books: []))
        prepareTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareHeaderView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("DidAppear")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Methods
    @IBAction func touchCancelSearch(_ sender: Any) {
        searchTextField.insertText("")
        searchTextField.resignFirstResponder()
    }
    
    @IBAction func touchFilter(_ sender: Any) {
        let vc = FilterVC(presenter.filter, spellList: self)
        let transitionDelegate = SPStorkTransitioningDelegate()
        transitionDelegate.hapticMoments = []
        transitionDelegate.showCloseButton = false
        vc.transitioningDelegate = transitionDelegate
        vc.modalPresentationStyle = .custom
        vc.modalPresentationCapturesStatusBarAppearance = true
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func searchEditingChanged(_ sender: Any) {
        presenter.search(searchTextField.text ?? "")
    }
    
    // MARK: - AnimationShow
    fileprivate func animationKeyboardShow(_ duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.headerLabel.alpha = 0
            self.filterButton.alpha = 0
            self.textFieldRightConstraint.isActive = false
            self.cancelButtonRightConstraint.isActive = true
            self.headerLabelSafeAreaTopConstraint.isActive = false
            self.headerLabelTopConstraint.isActive = true
            self.filterButtonSafeAreaTopConstraint.isActive = false
            self.filterButtonTopConstraint.isActive = true
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - AnimationHide
    fileprivate func animationKeyboardHide(_ duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.headerLabel.alpha = 1
            self.filterButton.alpha = 1
            self.cancelButtonRightConstraint.isActive = false
            self.textFieldRightConstraint.isActive = true
            self.headerLabelTopConstraint.isActive = false
            self.headerLabelSafeAreaTopConstraint.isActive = true
            self.filterButtonTopConstraint.isActive = false
            self.filterButtonSafeAreaTopConstraint.isActive = true
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            spellsTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            let animateDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber
            animationKeyboardShow(TimeInterval(truncating: animateDuration ?? 0.2))
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        let animateDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber
        animationKeyboardHide(TimeInterval(truncating: animateDuration ?? 0.2))
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
    
    private func prepareTableView() {
        spellsTableView.register(UINib(nibName: "SpellCell", bundle: nil), forCellReuseIdentifier: identifier)
        spellsTableView.tableFooterView = UIView()
    }
}

// MARK: - Input
extension SpellListVC: SpellListInput {
    
    func applyFilter(_ filter: Filter) {
        presenter.filter = filter
        presenter.search(searchTextField.text)
    }
    
    func reloadTableView() {
        spellsTableView.reloadData()
    }
}

// MARK: - TableViewDataSource
extension SpellListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        let vc = SpellVC()
        vc.spell = presenter.spells[indexPath.row]
        let transitionDelegate = SPStorkTransitioningDelegate()
        transitionDelegate.hapticMoments = []
        transitionDelegate.showCloseButton = false
        vc.transitioningDelegate = transitionDelegate
        vc.modalPresentationStyle = .custom
        vc.modalPresentationCapturesStatusBarAppearance = true
        self.present(vc, animated: true, completion: nil)
    }
}

// MARK: - TextFieldDelegate
extension SpellListVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        return true
    }
}
