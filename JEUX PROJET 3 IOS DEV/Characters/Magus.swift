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
        super.init(name: name, weapon: Stick(), crit: 20,type: "healer", maxLife: 55)
    }
    
    /////////////////////////////
    ////function healing////////
    /////////////////////////////
    func heal(who: Character) {
        
        let numberCrit = Int.random(in: 1 ... (100/crit)) // random number for critical heal
        var healFactor: Decimal = 1.00 // heal factor it depends of character type
        var critFactor: Decimal = 1.00 // crit factor
        //healing a type rock
        if  who.type == "rock"{
            healFactor = healFactor/4.00
        }
        //healing a type elf
        if  who.type == "elf"{
            healFactor = healFactor * 1.20
        }
        if who.checkCharacterLife(){
            if numberCrit == 1{
                
                critFactor = 2
                who.life = who.life + (weapon.heal * healFactor * critFactor)
                print("your heal has crit !!!")
                
            }else{
                who.life = who.life + (weapon.heal * healFactor)
            }
            print("\(name) heals \(who.name)  for \(weapon.heal * healFactor * critFactor) Life points " )
        }
        if who.life > who.maxLife {
            print(who.name + " is over healed, he's max of life")
            who.life = who.maxLife
            
        }
    }
    
}
