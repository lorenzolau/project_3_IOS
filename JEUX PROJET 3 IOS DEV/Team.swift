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

    
    var type_of_spell: String = ""
    
    // display and character choice
    
    
    func characters_display(){
        
        for i in 0..<characters_in_team.count{
            
            //character constant in for character in team
            let character_disp: Character = characters_in_team[i]
            
            if character_disp.check_caracter_life() {
                if character_disp.type == .Magus {
                    type_of_spell = "Heal"
                } else {
                    type_of_spell = "Damage"
                }
                
                print("\(i + 1) - " + character_disp.type.rawValue + " "
                    + character_disp.name + " - Life : \(character_disp.life) - Object :  " + type_of_spell)
                
            } else {
                print("\(i + 1) - " + character_disp.type.rawValue + character_disp.name + " is dead")
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
