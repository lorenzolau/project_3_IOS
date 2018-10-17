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
    var characters_in_team = [Character]() //character in array
    var type_of_spell: String = "" // fighting type
    
    // function who display characters
    func characters_display(){
        
        for i in 0..<characters_in_team.count{
            
            //character constant for listing character in team
            let character_disp: Character = characters_in_team[i]
            
            if character_disp.check_caracter_life() {
                if character_disp.type == .Magus {
                    type_of_spell = "Heal for \(character_disp.weapon.heal) life points"
                } else {
                    type_of_spell = "Deal \(character_disp.weapon.damage) damages"
                }
                
                print("N°\(i + 1) - \(character_disp.name) is a \(character_disp.type) of type \(character_disp.type.rawValue)"
                    
                + "he has : \(character_disp.life) life, he can \(type_of_spell)")
                
            } else {
                print("Character N°\(i + 1) - " + character_disp.type.rawValue + " " + character_disp.name + " is dead")
            }
        }
       
        
    }
    // Check life of all characters
    func check_life() -> Bool {
        
        var is_character_alife: Int = 0 //
        
        for character_disp in characters_in_team {
            if character_disp.check_caracter_life() {
                is_character_alife += 1
            }
        }
        
        // if alive = 0, team is defeated
        return is_character_alife > 0
    }
}
