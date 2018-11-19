//
//  Team.swift
//  JEUX PROJET 3 IOS DEV
//
//  Created by Pyran on 18/09/2018.
//  Copyright © 2018 Spirox. All rights reserved.
//

import Foundation

class Team {
    var name = "" //name of the team
    var charactersInTeam = [Character]() //character in array
    var typeOfSpell: String = "" // fighting type
    
    // function who display characters
    func charactersDisplay(){
        for i in 0..<charactersInTeam.count{
            let displayDescription: Character = charactersInTeam[i]
            if displayDescription.checkCharacterLife() {
                if displayDescription.type == "healer" {
                    typeOfSpell = "Heal for \(displayDescription.weapon.heal) life points"
                } else {
                    typeOfSpell = "Deal \(displayDescription.weapon.damage) damages"
                }
                print("N°\(i + 1) - \(displayDescription.name) is a \(displayDescription.type) of type \(displayDescription.type)"
                    + " he has : \(displayDescription.life) life, he can \(typeOfSpell)")
            } else {
                print("Character N°\(i + 1) - " + displayDescription.type + " " + displayDescription.name + " is dead")
            }
        }
    }
    // Check life of all characters
    func check_life() -> Bool {
        var is_character_alife: Int = 0 //
        for displayDescription in charactersInTeam {
            if displayDescription.checkCharacterLife() {
                is_character_alife += 1
            }
        }
        return is_character_alife > 0
    }
}
