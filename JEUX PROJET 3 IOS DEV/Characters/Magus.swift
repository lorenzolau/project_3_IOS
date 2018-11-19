//
//  Magus.swift
//  JEUX PROJET 3 IOS DEV
//
//  Created by Pyran on 19/09/2018.
//  Copyright © 2018 Spirox. All rights reserved.
//

import Foundation

class Magus: Character {
    

    init(name: String) {
        super.init(name: name, weapon: Stick(), crit: 20,type: "healer", max_life: 55)
    }
    
    /////////////////////////////
    ////function healing////////
    /////////////////////////////
    func heal(who: Character) {
        
        let number_crit = Int.random(in: 1 ... (100/crit)) // random number for critical heal
        var heal_factor: Decimal = 1.00 // heal factor it depends of character type
        var crit_factor: Decimal = 1.00 // crit factor
        //healing a type rock
        if  who.type == "rock"{
            heal_factor = heal_factor/4.00
        }
        //healing a type elf
        if  who.type == "elf"{
            heal_factor = heal_factor * 1.20
        }
        if who.checkCharacterLife(){
        if number_crit == 1{
            
            crit_factor = 2
            who.life = who.life + (weapon.heal * heal_factor * crit_factor)
            print("your heal has crit !!!")
            
        }else{
            who.life = who.life + (weapon.heal * heal_factor)
        }
        print("\(name) heals \(who.name)  for \(weapon.heal * heal_factor * crit_factor) Life points " )
        }
        if who.life > who.max_life {
            print(who.name + " is over healed, he's max of life")
            who.life = who.max_life
            
        }
    }
    
}
