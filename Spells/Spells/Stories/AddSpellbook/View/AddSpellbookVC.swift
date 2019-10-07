//
//  AddSpellbookVC.swift
//  Spells
//
//  Created by Sergey Melnikov on 03/10/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit

class AddSpellbookVC: UIViewController {

    // MARK: - Properties
    private var presenter: AddSpellbookOutput!
    @IBOutlet private var textField: UITextField!
    @IBOutlet private var cancelButton: UIButton!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.attributedPlaceholder = NSAttributedString(string: "Введите название книги", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: .placeholder)!])
        presenter = AddSpellbookPresenter(self, service: SpellService.shared())
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
extension AddSpellbookVC: AddSpellbookInput {
    func hide() {
        dismiss(animated: true)
    }
    
    func error(_ message: String) {
        let alerVC = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alerVC.addAction(UIAlertAction(title: "ОК", style: .default, handler: { (action) in
            alerVC.dismiss(animated: true, completion: nil)
        }))
        present(alerVC, animated: true, completion: nil)
    }
    
    
}

// MARK: - TextFieldDelegate
extension AddSpellbookVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        presenter.createSpellbook(textField.text ?? "")
        return true
    }
}
