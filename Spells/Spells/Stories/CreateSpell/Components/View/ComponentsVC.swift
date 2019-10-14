//
//  ComponentsVC.swift
//  Spells
//
//  Created by Sergey Melnikov on 11.10.2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit

fileprivate let professionsSugue = "Professions"

class ComponentsVC: UIViewController {

    // MARK: - Properties
    private var presenter: ComponentsOutput!
    @IBOutlet private var vSwitch: UISwitch!
    @IBOutlet private var sSwitch: UISwitch!
    @IBOutlet private var mSwitch: UISwitch!
    @IBOutlet private var materialTextField: UITextField!
    @IBOutlet var nextButton: NextButton!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? ProfessionsInput, let spell = sender as? Spell else { fatalError() }
        vc.spell = spell
    }
    
    // MARK: - Methods
    @IBAction func touchCancel() {
        dismiss(animated: true)
    }
    
    @IBAction func changedMaterialComponent(_ sender: Any) {
        UIView.animate(withDuration: 0.2) {
            self.materialTextField.isHidden = !self.mSwitch.isOn
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func touchNext(_ sender: Any) {
        presenter.saveComponents(v: vSwitch.isOn, s: sSwitch.isOn, m: mSwitch.isOn, materials: materialTextField.text)
    }
}

// MARK: - Input
extension ComponentsVC: ComponentsInput {
    var spell: Spell! {
        get {
            return presenter.spell
        }
        set {
            if presenter == nil { presenter = ComponentsPresenter(self) }
            presenter.spell = newValue
        }
    }
    
    func showNextVC() {
        performSegue(withIdentifier: professionsSugue, sender: presenter.spell)
    }
}

// MARK: - UITextFieldDelegate
extension ComponentsVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        touchNext("")
        return true
    }
}
