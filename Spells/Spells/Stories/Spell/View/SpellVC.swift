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
    private var presenter: SpellOutput!
    @IBOutlet private var nameLabel: HeaderBottom!
    
    @IBOutlet private var levelView: UIView!
    @IBOutlet private var levelLabel: TextTag!
    
    @IBOutlet private var schoolView: UIView!
    @IBOutlet private var schoolLabel: TextTag!
    
    @IBOutlet private var radiusView: UIStackView!
    @IBOutlet private var radiusNameLabel: Text2!
    @IBOutlet private var radiusLabel: Text2!
    
    
    @IBOutlet private var durationView: UIStackView!
    @IBOutlet private var durationNameLabel: Text2!
    @IBOutlet private var durationLabel: Text2!
    
    
    @IBOutlet private var castView: UIStackView!
    @IBOutlet private var castNameLabel: Text2!
    @IBOutlet private var castLabel: Text2!
    
    
    @IBOutlet private var componentsView: UIStackView!
    @IBOutlet private var componentsNameLabel: Text2!
    @IBOutlet private var componentsLabel: Text2!
    
    
    @IBOutlet private var materialView: UIStackView!
    @IBOutlet private var materialNameLabel: Text2!
    @IBOutlet private var materialLabel: Text2!
    
    @IBOutlet private var infoLabel: UILabel!
    
    @IBOutlet private var professtionsNameLabel: Text2!
    @IBOutlet private var professionsLabel: Text2!
    
    @IBOutlet private var booksNameLabel: Text2!
    @IBOutlet private var booksLabel: Text2!
    
    @IBOutlet private var likeButton: UIButton!
    @IBOutlet private var addSpellbookButton: UIButton!
    
    var likeButtonHidden: Bool = false
    var addSpellbookButtonHidden: Bool = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    // MARK: - Life cycle
    required convenience init(_ spell: Spell) {
        self.init()
        presenter = SpellPresenter(self, service: SpellService.shared(), spell: spell)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        likeButton.setImage(presenter.isFavorites ? UIImage(named: "likeOn") : UIImage(named: "like"), for: .normal)
        likeButton.isHidden = likeButtonHidden
        addSpellbookButton.isHidden = addSpellbookButtonHidden
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }

    // MARK: - Methods
    @IBAction func touchLike(_ sender: Any) {
        presenter.changeFavorite()
    }
    
    @IBAction func touchAddSpellInSpellbook(_ sender: Any) {
        
    }
    
    private func updateUI() {
        let spell = presenter.spell
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

// MARK: - Input
extension SpellVC: SpellInput {
    func notification(_ message: String) {
        likeButton.setImage(presenter.isFavorites ? UIImage(named: "likeOn") : UIImage(named: "like"), for: .normal)
        print(message)
    }
}

// MARK: - ScrollViewDelegate
extension SpellVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        SPStorkController.scrollViewDidScroll(scrollView)
    }
}
