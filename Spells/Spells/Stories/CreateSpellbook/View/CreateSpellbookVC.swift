//
//  AddSpellbookVC.swift
//  Spells
//
//  Created by Sergey Melnikov on 03/10/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit
import NotificationBannerSwift

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
        dismiss(animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            return .default
        }
    }
}

// MARK: - Input
extension CreateSpellbookVC: CreateSpellbookInput {
    func success() {
        let banner = StatusBarNotificationBanner(title: "\(textField.text ?? "") создана!", style: .success)
        banner.duration = 0.2
        banner.show()
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
