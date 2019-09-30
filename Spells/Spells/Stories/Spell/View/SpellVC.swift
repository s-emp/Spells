//
//  SpellVC.swift
//  Spells
//
//  Created by Sergey Melnikov on 25/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit
import SPStorkController

class SpellVC: UIViewController {
    
    // MARK: - Properties
    var spell: Spell?
    @IBOutlet var nameLabel: HeaderBottom!
    
    @IBOutlet var levelView: UIView!
    @IBOutlet var levelLabel: TextTag!
    
    @IBOutlet var schoolView: UIView!
    @IBOutlet var schoolLabel: TextTag!
    
    @IBOutlet var radiusView: UIStackView!
    @IBOutlet var radiusNameLabel: Text2!
    @IBOutlet var radiusLabel: Text2!
    
    
    @IBOutlet var durationView: UIStackView!
    @IBOutlet var durationNameLabel: Text2!
    @IBOutlet var durationLabel: Text2!
    
    
    @IBOutlet var castView: UIStackView!
    @IBOutlet var castNameLabel: Text2!
    @IBOutlet var castLabel: Text2!
    
    
    @IBOutlet var componentsView: UIStackView!
    @IBOutlet var componentsNameLabel: Text2!
    @IBOutlet var componentsLabel: Text2!
    
    
    @IBOutlet var materialView: UIStackView!
    @IBOutlet var materialNameLabel: Text2!
    @IBOutlet var materialLabel: Text2!
    
    @IBOutlet var infoLabel: UILabel!
    
    @IBOutlet var professtionsNameLabel: Text2!
    @IBOutlet var professionsLabel: Text2!
    
    @IBOutlet var booksNameLabel: Text2!
    @IBOutlet var booksLabel: Text2!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }

    // MARK: - Methods
    @IBAction func touchLike(_ sender: Any) {
        
    }
    
    @IBAction func touchAddSpellInSpellbook(_ sender: Any) {
        
    }
    
    private func updateUI() {
        guard let spell = spell else { return }
        nameLabel.text = spell.name
        levelLabel.text = spell.level == 0 ? "Заговор" : "\(spell.level) уровня"
        schoolView.backgroundColor = UIColor(named: UIColor.Palette(rawValue: spell.school.rawValue)!)
        schoolLabel.text = spell.school.fullName(Language.systemLanguage)
        radiusLabel.text = spell.range
        durationLabel.text = spell.duration
        castLabel.text = spell.action
        componentsLabel.text = spell.components.map { $0.fullName(Language.systemLanguage) }.joined(separator: " ")
        if let materials = spell.materials {
            materialView.isHidden = true
            materialLabel.text = materials
        }
        infoLabel.text = spell.info
        professionsLabel.text = spell.professions.map { $0.fullName(Language.systemLanguage) }.joined(separator: ", ")
        booksLabel.text = spell.books.map { $0.fullName(Language.systemLanguage) }.joined(separator: ", ")
        
        do {
            let diceRegex = try NSRegularExpression(pattern: "[0-9]{1,}[кd][0-9]{1,}")
            let boldRegex = try NSRegularExpression(pattern: "<b>.*?</b>")
            let diceResult = diceRegex.matches(in: spell.info, range: NSRange(spell.info.startIndex..., in: spell.info))
            let boldResult = boldRegex.matches(in: spell.info, range: NSRange(spell.info.startIndex..., in: spell.info))
            let attributeString = NSMutableAttributedString(string: spell.info, attributes: [.font: UIFont.systemFont(ofSize: 15), .foregroundColor: UIColor(named: .text)!])
            diceResult.forEach {
                attributeString.addAttributes([.font: UIFont.boldSystemFont(ofSize: 15), .foregroundColor: UIColor(named: .diceTextColor)!], range: $0.range)
                
            }
            var space = 0
            boldResult.forEach {
                var boldRange = $0.range
                boldRange.location += 3 - space
                boldRange.length -= 7
                attributeString.addAttributes([.font: UIFont.boldSystemFont(ofSize: 15), .foregroundColor: UIColor(named: .text)!], range: boldRange)
                var removeRange = $0.range
                removeRange.location -= space
                removeRange.length = 3
                attributeString.replaceCharacters(in: removeRange, with: "")
                removeRange = $0.range
                removeRange.location = removeRange.location + removeRange.length - 7 - space
                removeRange.length = 4
                attributeString.replaceCharacters(in: removeRange, with: "")
                space += 7
            }
            infoLabel.attributedText = attributeString
        } catch {
            
        }
    }
}

extension SpellVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        SPStorkController.scrollViewDidScroll(scrollView)
    }
}
