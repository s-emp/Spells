//
//  ParamsVC.swift
//  Spells
//
//  Created by Sergey Melnikov on 11.10.2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit

fileprivate let componentsSegue = "Components"

class ParamsVC: UIViewController {

    // MARK: - Properties
    private var presenter: ParamsOutput!
    @IBOutlet var levelButton: UIButton!
    @IBOutlet var levelPickerView: UIPickerView!
    @IBOutlet var schoolButton: UIButton!
    @IBOutlet var schoolPickerView: UIPickerView!
    @IBOutlet var rangeTextField: UITextField!
    @IBOutlet var durationTextField: UITextField!
    @IBOutlet var actionTextField: UITextField!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? ComponentsInput, let spell = sender as? Spell else { fatalError() }
        vc.spell = spell
    }
    
    // MARK: - Methods
    @IBAction func touchCancel() {
        dismiss(animated: true)
    }
    
    private func showLevelPicker() {
        
    }
    
    @IBAction func touchChangeLevel(_ sender: Any) {
        let row = levelPickerView.selectedRow(inComponent: 0)
        levelButton.setTitle(levelPickerView.isHidden ? "Сохранить" : "\(row == 0 ? "Заговор" : String(row))", for: .normal)
        UIView.animate(withDuration: 0.2) {
            self.levelPickerView.isHidden.toggle()
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func touchChangeSchool(_ sender: Any) {
        let row = schoolPickerView.selectedRow(inComponent: 0)
        schoolButton.setTitle(schoolPickerView.isHidden ? "Сохранить" : School.allCases[row].fullName(Language.systemLanguage), for: .normal)
        UIView.animate(withDuration: 0.2) {
            self.schoolPickerView.isHidden.toggle()
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func touchNext(_ sender: Any) {
        presenter.saveParams(levelPickerView.selectedRow(inComponent: 0), school: School.allCases[schoolPickerView.selectedRow(inComponent: 0)], range: rangeTextField.text, duration: durationTextField.text, action: actionTextField.text)
    }
}

// MARK: - Input
extension ParamsVC: ParamsInput {
    var spell: Spell! {
        get {
            return presenter.spell
        }
        set {
            if presenter == nil {
                presenter = ParamsPresenter(self)
            }
            presenter.spell = newValue
        }
    }
    
    func showNextVC() {
        performSegue(withIdentifier: componentsSegue, sender: presenter.spell)
    }
    
    func error(_ message: String) {
        UIAlertController.showDefaultErrorAlert(message, vc: self)
    }
}

// MARK: - UIPickerViewDataSource
extension ParamsVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == levelPickerView {
            return 10
        } else if pickerView == schoolPickerView {
            return School.allCases.count
        } else {
            return 0
        }
    }
}

// MARK: - UIPickerViewDelegate
extension ParamsVC: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == levelPickerView {
            return row == 0 ? "Заговор" : String(row)
        } else if pickerView == schoolPickerView {
            return School.allCases[row].fullName(Language.systemLanguage)
        } else {
            return nil
        }
    }
}

// MARK: - UITextFieldDelegate
extension ParamsVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        touchNext("")
        return true
    }
}
