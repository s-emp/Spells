//
//  ProfessionsVC.swift
//  Spells
//
//  Created by Сергей Мельников on 12.10.2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit
import NotificationBannerSwift

class ProfessionsVC: UIViewController {
    
    // MARK: - Properties
    private var presenter: ProfessionsOutput!
    @IBOutlet var bardSwitch: UISwitch!
    @IBOutlet var clericSwitch: UISwitch!
    @IBOutlet var druidSwitch: UISwitch!
    @IBOutlet var paladinSwitch: UISwitch!
    @IBOutlet var rangerSwitch: UISwitch!
    @IBOutlet var sorcererSwitch: UISwitch!
    @IBOutlet var warlockSwitch: UISwitch!
    @IBOutlet var wizardSwitch: UISwitch!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Methods
    @IBAction func touchCancel() {
        dismiss(animated: true)
    }
    
    @IBAction func touchSpellSave(_ sender: Any) {
        presenter.saveSpell(bard: bardSwitch.isOn, wizard: wizardSwitch.isOn, druid: druidSwitch.isOn, cleric: clericSwitch.isOn, warlock: warlockSwitch.isOn, paladin: paladinSwitch.isOn, ranger: rangerSwitch.isOn, sorcerer: sorcererSwitch.isOn)
    }
    
}

extension ProfessionsVC: ProfessionsInput {
    var spell: Spell! {
        get { return presenter.spell }
        set {
            if presenter == nil {
                presenter = ProfessionsPresenter(self, service: SpellService.shared())
            }
            presenter.spell = newValue
        }
    }
    func success() {
        let banner = FloatingNotificationBanner(title: "\(presenter.spell.name) создано!", subtitle: "Ваша заклинаний успешно создана 🥳", style: .success)
        banner.show()
        dismiss(animated: true)
    }
}
