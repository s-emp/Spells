//
//  DescriptionCSVC.swift
//  Spells
//
//  Created by Sergey Melnikov on 10.10.2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit

fileprivate let paramsSegue = "Params"

class DescriptionCSVC: UIViewController {

    // MARK: - Properties
    private var presenter: DescriptionCSOutput!
    @IBOutlet var descriptionTextField: UITextField!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        descriptionTextField.becomeFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? ParamsInput, let spell = sender as? Spell else { fatalError() }
        vc.spell = spell
    }

    // MARK: - Methods
    @IBAction func touchCancel() {
        dismiss(animated: true)
    }
}

// MARK: - Input
extension DescriptionCSVC: DescriptionCSInput {
    var spell: Spell! {
        get {
            return presenter.spell
        }
        set {
            if presenter == nil {
                presenter = DescriptionCSPresenter(self)
            }
            presenter.spell = newValue
        }
    }
    
    func showNextVC() {
        performSegue(withIdentifier: paramsSegue, sender: presenter.spell)
    }
}

// MARK: - UITextFieldDelegate
extension DescriptionCSVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        presenter.saveInformation(descriptionTextField.text)
        return true
    }
}
