//
//  Component.swift
//  Spells
//
//  Created by Сергей Мельников on 20/09/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

enum Component: String, Codable {
    case v
    case s
    case m
    
    func shortName(_ language: Language) -> String {
        switch language {
        case .ru:
            switch self {
            case .v:
                return "в"
            case .s:
                return "с"
            case .m:
                return "м"
            }
        case .en:
            switch self {
            case .v:
                return "v"
            case .s:
                return "s"
            case .m:
                return "m"
            }
        }
    }
    
    func fullName(_ language: Language) -> String {
        switch language {
        case .ru:
            switch self {
            case .v:
                return "Вербальный"
            case .s:
                return "Соматический"
            case .m:
                return "Материальный"
            }
        case .en:
            switch self {
            case .v:
                return "Verbal"
            case .s:
                return "Somatic"
            case .m:
                return "Material"
            }
        }

    }
    
    func info(_ language: Language) -> String {
        switch language {
        case .ru:
            switch self {
            case .v:
                return "Большинство заклинаний требуют произношения таинственных слов. Сами по себе слова не являются источником силы заклинания; просто комбинация звуков с особой тональностью вызывает резонанс в прядях магии, приводя их в движение. Таким образом, персонаж с кляпом во рту или в области заклинания тишина, не может активировать заклинания с вербальным компонентом."
            case .s:
                return "Заклинание может требовать энергичной жестикуляции или замысловатой последовательности телодвижений. Если у заклинания есть соматический компонент, у заклинателя должна быть свободной хотя бы одна рука для исполнения этих жестов."
            case .m:
                return "Накладывание некоторых заклинаний требует наличия особых предметов, указанных в скобках в описании заклинания. Персонаж может использовать мешочек с компонентами или заклинательную фокусировку (смотрите в главе 5) вместо указанных компонентов. Однако, если для компонента указана цена, у персонажа для накладывания заклинания должен быть именно такой компонент. Если в заклинании сказано, что материальные компоненты расходуются, заклинатель должен предоставить компоненты для каждого использования этого заклинания. У заклинателя должна быть одна свободная рука для доступа к материальным компонентам, но это может быть та же самая рука, что используется для выполнения соматического компонента."
            }
        case .en:
            switch self {
            case .v:
                return "Most Spells require the chanting of mystic words. The words themselves aren’t the source of the spell’s power; rather, the particular combination of sounds, with specific pitch and resonance, sets the threads of magic in motion. Thus, a character who is gagged or in an area of Silence, such as one created by the Silence spell, can’t Cast a Spell with a verbal component."
            case .s:
                return "Spellcasting gestures might include a forceful gesticulation or an intricate set of gestures. If a spell requires a somatic component, the caster must have free use of at least one hand to perform these gestures."
            case .m:
                return "Casting some Spells requires particular Objects, specified in parentheses in the component entry. A character can use a Component pouch or a Spellcasting focus (found in “Equipment”) in place of the Components specified for a spell. But if a cost is indicated for a component, a character must have that specific component before he or she can cast the spell. If a spell states that a material component is consumed by the spell, the caster must provide this component for each casting of the spell. A spellcaster must have a hand free to access a spell’s material components—or to hold a Spellcasting focus—but it can be the same hand that he or she uses to perform somatic Components."
            }
        }
    }
}

extension Component: CustomStringConvertible {
    var description: String {
        return self.rawValue
    }
}
