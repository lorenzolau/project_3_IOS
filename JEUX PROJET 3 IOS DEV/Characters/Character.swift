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
    let max_life: Decimal
    var crit: Int
    var type: String
    
    init(name: String, weapon: Weapon, crit: Int,type: String, max_life: Decimal) {
        self.name = name
        self.weapon = weapon
        self.crit = crit
        self.type = type
        
        self.max_life = max_life
        self.life = max_life
        
}
    /////////////////////////////
    ////function attack//////////
    /////////////////////////////
    func attack(who: Character) {
        //a random number for crit attack 1/10 chance
        let number_crit = Int.random(in: 1 ... (100/crit))
        var attack_factor: Decimal = 1
      
        var crit_factor: Decimal = 1.00
         //types :
        //human vs rock
        print("Type \(type) vs type \(who.type)")
        
        if type == "human" && who.type == "rock"{attack_factor = type_factor(attack_factor_par: 0.25)}
        //human vs elf
        if type == "human" && who.type == "elf"{attack_factor = type_factor(attack_factor_par: 1.5)}
        //rock vs human
        if type == "rock" && who.type == "human"{attack_factor = type_factor(attack_factor_par: 1.5)}
        //rock vs elf
        if type == "rock" && who.type == "elf"{attack_factor = type_factor(attack_factor_par: 1.8)}
        //elf vs rock
        if type == "elf" && who.type == "rock"{attack_factor = type_factor(attack_factor_par: 0.5)}
        //elf vs human
        if type == "elf" && who.type == "human"{attack_factor = type_factor(attack_factor_par: 0.75)}
        //if crit
        //let decimalToInt = NSDecimalNumber(decimal: attack_factor).intValue
        
        if number_crit == 1{
            crit_factor = 2
            who.life = who.life - (weapon.damage * attack_factor * crit_factor)
            print("your attack has crit !!!")
        }else{
            who.life = who.life - (weapon.damage * attack_factor)
        }
        //check if character is dead and say it to player
        character_dead(who: who, attack_factor: attack_factor, crit_factor: crit_factor)
        
    }
    //////////////////////////////////////////////////////////
    ////////function check life return a boolean//////////////
    //////////////////////////////////////////////////////////
     func check_caracter_life() -> Bool{
        return life > 0
    }
    //////////////////////////////////////////////////////////
    ////////function type factor//////////////
    //////////////////////////////////////////////////////////
    func type_factor(attack_factor_par: Decimal) -> Decimal{
        
        var factor: Decimal = 1
        //var factor depends what kind of character type
        factor = factor * attack_factor_par
        print("attack factor : \(factor)")
        
        return factor
    }
    ///////////////////////////////////
    ///function check dead character///
    ///////////////////////////////////
    func character_dead (who: Character, attack_factor: Decimal, crit_factor: Decimal){
        
        if who.life < 0 {
            who.life = 0
        }
        // check figther alive ?
        if self.check_caracter_life() {
            // Character to attack alive ?
            if who.check_caracter_life() {
                print(name + " hit " + who.name)
                //if oponent life < 0 then life = 0
                who.life = max(who.life, 0)
                
                if who.life <= 0 {
                    print(who.name + " is defeted")
                } else {
                    print(who.name + " loose \(weapon.damage * attack_factor * crit_factor) life")
                }
                
            } else {
                print(who.name + " is dead !")
            }
        } else {
            print(name + " he is already dead, sorry for you dude :(")
        }
    }

}
