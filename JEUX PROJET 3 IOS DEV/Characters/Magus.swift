//
//  Magus.swift
//  JEUX PROJET 3 IOS DEV
//
//  Created by Pyran on 19/09/2018.
//  Copyright © 2018 Spirox. All rights reserved.
//

import Foundation
//class magus details herited from Character
class Magus: Character {
    
    
    init(name: String) {
        super.init(name: name, weapon: Stick(), crit: 20,type: "healer", maxLife: 55, classType: .magus)
    }
    
    /////////////////////////////
    ////function healing////////
    /////////////////////////////
    func heal(characterToHeal: Character) {
        
        let numberCrit = Int.random(in: 1 ... (100/crit)) // random number for critical heal
        var healFactor: Decimal = 1.00 // heal factor it depends of character type
        var critFactor: Decimal = 1.00 // crit factor
        //healing a type rock
        if  characterToHeal.type == "rock"{
            healFactor = healFactor/4.00
        }
        //healing a type elf
        if  characterToHeal.type == "elf"{
            healFactor = healFactor * 1.20
        }
        if characterToHeal.checkCharacterLife(){
            if numberCrit == 1{
                
                critFactor = 2
                characterToHeal.life = characterToHeal.life + (weapon.heal * healFactor * critFactor)
                print("your heal has crit !!!")
                
            }else{
                characterToHeal.life = characterToHeal.life + (weapon.heal * healFactor)
            }
            print("\(name) heals \(characterToHeal.name)  for \(weapon.heal * healFactor * critFactor) Life points " )
        }
        if characterToHeal.life > characterToHeal.maxLife {
            print(characterToHeal.name + " is over healed, he's max of life")
            characterToHeal.life = characterToHeal.maxLife
            
        }
    }
    
}
