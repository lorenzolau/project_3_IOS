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
    var charactersInTeam = [Character]()
    
    ////////////////////////////////////////////////
    //////// function who display characters////////
    ////////////////////////////////////////////////
    func charactersDisplay(){
        var typeOfSpell: String
        for i in 0..<charactersInTeam.count{
            let displayDescription: Character = charactersInTeam[i]
            if displayDescription.checkCharacterLife() {
                if displayDescription is Magus{
                    typeOfSpell = "Heal for \(displayDescription.weapon.heal) life points"
                } else {
                    typeOfSpell = "Deal \(displayDescription.weapon.damage) damages"
                }
                print("N°\(i + 1) - \(displayDescription.name) is a \(displayDescription) of type \(displayDescription.type)"
                    + " he has : \(displayDescription.life) life, he can \(typeOfSpell)")
            } else {
                print(displayDescription.name + " is dead")
            }
        }
    }
    
    ///////////////////////////////////////////////
    //////// Check life of TEAM ///////////////////
    ///////////////////////////////////////////////
    func isTeamAlife() -> Bool {
        var checkCharacterLife: Int = 0 //
        for displayDescription in charactersInTeam {
            if displayDescription.checkCharacterLife() {
                checkCharacterLife += 1
            }
        }
        return checkCharacterLife > 0
    }
}
