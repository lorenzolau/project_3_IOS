//
//  Character.swift
//  JEUX PROJET 3 IOS DEV
//
//  Created by Pyran on 18/09/2018.
//  Copyright © 2018 Spirox. All rights reserved.
//

import Foundation

// Create characters

enum Typeofcharacter: String {
    case Magus = "healer"
    case Combattant = "human"
    case Colosse = "rock"
    case Dwarf = "elf"
}

class Character {
    
    let name: String
    var weapon: Weapon
    var life: Decimal
    let max_life: Decimal
    var armor: Int
    var type: Typeofcharacter
    
    init(name: String, weapon: Weapon, armor: Int,type: Typeofcharacter, max_life: Decimal) {
        self.name = name
        self.weapon = weapon
        self.armor = armor
        self.type = type
        
        self.max_life = max_life
        self.life = max_life
        
}
    //function attack

    
    func attack(who: Character) {
        //a random number for crit attack 1/10 chance
        let number_crit = Int.random(in: 1 ... 10)
        var attack_factor: Decimal = 1.00
         //types :
        //human vs rock
        print("Type \(type.rawValue) vs type \(who.type.rawValue)")
        
        if type.rawValue == "human" && who.type.rawValue == "rock"{
            attack_factor = attack_factor/4.00
          }
        //human vs elf
        if type.rawValue == "human" && who.type.rawValue == "elf"{
            attack_factor = attack_factor * 1.50
        }
        //rock vs human
        if type.rawValue == "rock" && who.type.rawValue == "human"{
            attack_factor = attack_factor*1.50
          }
        //rock vs elf
        if type.rawValue == "rock" && who.type.rawValue == "elf"{
            attack_factor = attack_factor*1.80
         }
        //elf vs rock
        if type.rawValue == "elf" && who.type.rawValue == "rock"{
            attack_factor = attack_factor/2
          }
        //elf vs human
        if type.rawValue == "elf" && who.type.rawValue == "human"{
            attack_factor = attack_factor/1.20
        }
        print("attack factor : \(attack_factor)")
        
        //if crit
        //let decimalToInt = NSDecimalNumber(decimal: attack_factor).intValue
        
        if number_crit == 1{
            who.life = who.life - (weapon.damage * attack_factor*2)
            print("your attack has crit !!!")
        }else{
            who.life = who.life - (weapon.damage * attack_factor)
        }
        
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
                    print(who.name + " loose \(weapon.damage * attack_factor) life")
                }
                
            } else {
                print(who.name + " is dead !")
            }
        } else {
            print(name + " he is already dead, sorry for you dude :(")
        }
    }

     func check_caracter_life() -> Bool{
        return life > 0
    }
}
