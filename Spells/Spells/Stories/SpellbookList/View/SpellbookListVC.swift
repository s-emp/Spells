//
//  SpellbookListVC.swift
//  Spells
//
//  Created by Sergey Melnikov on 30/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit
import SPStorkController

fileprivate let identifier = "SpellbookCell"

class SpellbookListVC: UIViewController {
    
    // MARK: - Properties
    private var presenter: SpellbookListOutput!
    @IBOutlet var headerView: UIView!
    @IBOutlet var headerLabel: Header1!
    @IBOutlet var searchTextField: SearchTextField!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var textFieldRightConstraint: NSLayoutConstraint!
    @IBOutlet var cancelButtonRightConstraint: NSLayoutConstraint!
    @IBOutlet var headerLabelSafeAreaTopConstraint: NSLayoutConstraint!
    @IBOutlet var headerLabelTopConstraint: NSLayoutConstraint!
    
    @IBOutlet var spellbookTableView: UITableView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SpellbookListPresenter(self, service: SpellService.shared())
        prepareTableView()
        prepareHeaderView()
        prepareNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        spellbookTableView.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Methods
    
    @IBAction func touchCancel(_ sender: Any) {
        searchTextField.insertText("")
        searchTextField.resignFirstResponder()
    }
    
    // MARK: - AnimationShow
    fileprivate func animationKeyboardShow(_ duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.headerLabel.alpha = 0
            self.cancelButton.alpha = 1
            self.textFieldRightConstraint.isActive = false
            self.cancelButtonRightConstraint.isActive = true
            self.headerLabelSafeAreaTopConstraint.isActive = false
            self.headerLabelTopConstraint.isActive = true
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - AnimationHide
    fileprivate func animationKeyboardHide(_ duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.headerLabel.alpha = 1
            self.cancelButton.alpha = 0
            self.cancelButtonRightConstraint.isActive = false
            self.textFieldRightConstraint.isActive = true
            self.headerLabelTopConstraint.isActive = false
            self.headerLabelSafeAreaTopConstraint.isActive = true
            self.view.layoutIfNeeded()
        }
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            spellbookTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
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
extension SpellbookListVC {
    
    private func prepareTableView() {
        spellbookTableView.register(UINib(nibName: "SpellbookCell", bundle: nil), forCellReuseIdentifier: identifier)
        spellbookTableView.tableFooterView = UIView()
    }
    
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
extension SpellbookListVC: SpellbookListInput {
    
}

// MARK: - TextFieldDelegate
extension SpellbookListVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        return true
    }
}

// MARK: - TableViewDataSource
extension SpellbookListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.spellbooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? SpellbookCell else { return }
        cell.spellbook = presenter.spellbooks[indexPath.row]
    }
}

// MARK: - TableViewDelegate
extension SpellbookListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SpellbookVC(presenter.spellbooks[indexPath.row])
        let transitionDelegate = SPStorkTransitioningDelegate()
        transitionDelegate.hapticMoments = []
        transitionDelegate.showCloseButton = false
        vc.transitioningDelegate = transitionDelegate
        vc.modalPresentationStyle = .custom
        vc.modalPresentationCapturesStatusBarAppearance = true
        self.present(vc, animated: true, completion: nil)
    }
}
