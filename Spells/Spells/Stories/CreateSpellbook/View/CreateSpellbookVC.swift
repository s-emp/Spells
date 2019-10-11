//
//  AddSpellbookVC.swift
//  Spells
//
//  Created by Sergey Melnikov on 03/10/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit

class CreateSpellbookVC: UIViewController {

    // MARK: - Properties
    private var presenter: CreateSpellbookOutput!
    @IBOutlet private var textField: UITextField!
    @IBOutlet private var cancelButton: UIButton!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.attributedPlaceholder = NSAttributedString(string: "Введите название книги", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: .placeholder)])
        presenter = CreateSpellbookPresenter(self, service: SpellService.shared())
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    // MARK: - Methods
    @IBAction func touchCancel(_ sender: Any) {
        hide()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .default }
}

// MARK: - Input
extension CreateSpellbookVC: CreateSpellbookInput {
    func hide() {
        dismiss(animated: true)
    }
    
    func error(_ message: String) {
        UIAlertController.showDefaultErrorAlert(message, vc: self)
    }
    
    
}

// MARK: - TextFieldDelegate
extension CreateSpellbookVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        presenter.createSpellbook(textField.text ?? "")
        return true
    }
}