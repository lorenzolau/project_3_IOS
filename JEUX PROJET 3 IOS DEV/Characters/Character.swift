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
    case Magus = "Magus"
    case Combattant = "Figther"
    case Colosse = "Colosse"
    case Dwarf = "Dwarf"
}

class Character {
    
    let name: String
    var weapon: Weapon
    var life: Int
    let max_life: Int
    var armor: Int
    var type: Typeofcharacter
    
    init(name: String, weapon: Weapon, armor: Int,type: Typeofcharacter, max_life: Int) {
        self.name = name
        self.weapon = weapon
        self.armor = armor
        self.type = type
        
        self.max_life = max_life
        self.life = max_life
        
}
    //function attack

    
    func attack(who: Character) {
        
        who.life -= weapon.damage
        if who.life < 0 {
            who.life = 0
        }
        // check figther alive ?
        if self.check_caracter_life() {
            // Character to attack alive ?
            if who.check_caracter_life() {
                print(name + " fight " + who.name)
                
                who.life = max(who.life - weapon.damage, 0)
                
                if who.life == 0 {
                    print(who.name + " is defeted")
                } else {
                    print(who.name + " loose \(weapon.damage) life")
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
