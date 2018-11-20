//
//  Character.swift
//  JEUX PROJET 3 IOS DEV
//
//  Created by Pyran on 18/09/2018.
//  Copyright © 2018 Spirox. All rights reserved.
//

import Foundation

// Create characters

class Character {
    
    let name: String
    var weapon: Weapon
    var life: Decimal
    let maxLife: Decimal
    var crit: Int
    let type: String
    
    init(name: String, weapon: Weapon, crit: Int,type: String, maxLife: Decimal) {
        self.name = name
        self.weapon = weapon
        self.crit = crit
        self.type = type
        
        self.maxLife = maxLife
        self.life = maxLife
        
    }
    
    /////////////////////////////
    ////function attack//////////
    /////////////////////////////
    func attack(who: Character) {
        let numberCrit = Int.random(in: 1 ... (100/crit))
        var attackFactor: Decimal = 1
        var critFactor: Decimal = 1.00
        print("Type \(type) vs type \(who.type)")
        if type == "human" && who.type == "rock"{attackFactor = factorType(attackFactorParameter: 0.25)}
        if type == "human" && who.type == "elf"{attackFactor = factorType(attackFactorParameter: 1.5)}
        if type == "rock" && who.type == "human"{attackFactor = factorType(attackFactorParameter: 1.5)}
        if type == "rock" && who.type == "elf"{attackFactor = factorType(attackFactorParameter: 1.8)}
        if type == "elf" && who.type == "rock"{attackFactor = factorType(attackFactorParameter: 0.5)}
        if type == "elf" && who.type == "human"{attackFactor = factorType(attackFactorParameter: 0.75)}
        if numberCrit == 1{
            critFactor = 2
            print("your attack has crit !!!")
        }
        who.life = who.life - (weapon.damage * attackFactor * critFactor)
        
        //check if character is dead and say it to player
        IsCharacterDead(who: who, attackFactor: attackFactor, critFactor: critFactor)
    }
    //////////////////////////////////////////////////////////
    ////////function check life return a boolean//////////////
    //////////////////////////////////////////////////////////
    func checkCharacterLife() -> Bool{
        return life > 0
    }
    //////////////////////////////////////////////////////////
    ////////function type factor//////////////
    //////////////////////////////////////////////////////////
    func factorType(attackFactorParameter: Decimal) -> Decimal{
        var factor: Decimal = 1
        factor = factor * attackFactorParameter
        print("attack factor : \(factor)")
        return factor
    }
    ///////////////////////////////////
    ///function check dead character///
    ///////////////////////////////////
    func IsCharacterDead (who: Character, attackFactor: Decimal, critFactor: Decimal){
        
        if self.checkCharacterLife() {
            // Character to attack alive ?
            if who.checkCharacterLife() {
                print(name + " hit " + who.name)
                //if oponent life < 0 then life = 0
                who.life = max(who.life, 0)
                if who.life <= 0 {
                    print(who.name + " is defeted")
                }
                print(who.name + " loose \(weapon.damage * attackFactor * critFactor) life")
            } else {
                print(who.name + " is dead !")
            }
        } else {
            print(name + "  is dead, choose another")
        }
    }
    
}
