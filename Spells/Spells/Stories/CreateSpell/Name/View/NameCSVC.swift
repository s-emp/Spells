//
//  NameCSVC.swift
//  Spells
//
//  Created by Sergey Melnikov on 10.10.2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit

class NameCSVC: UIViewController {
    
    // MARK: - Properties
    private var presenter: NameCSOutput!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var nextButton: NextButton!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = NameCSPresenter(self, service: SpellService.shared())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameTextField.becomeFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? DescriptionCSInput, let spell = sender as? Spell else { fatalError() }
        vc.spell = spell
    }
    
    // MARK: - Methods
    @IBAction func touchCancel() {
        nameTextField.resignFirstResponder()
    }
}

// MARK: - Input
extension NameCSVC: NameCSInput {
    func showNextVC() {
        performSegue(withIdentifier: "Desc", sender: presenter.spell)
    }
    
    func error(_ message: String) {
        UIAlertController.showDefaultErrorAlert(message, vc: self)
    }
}

// MARK: - UITextFieldDelegate
extension NameCSVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        presenter.saveName(nameTextField.text)
        return true
    }
}
