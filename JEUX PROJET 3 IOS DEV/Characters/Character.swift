//
//  Character.swift
//  JEUX PROJET 3 IOS DEV
//
//  Created by Pyran on 18/09/2018.
//  Copyright © 2018 Spirox. All rights reserved.
//

import Foundation

//class names used in function character display list
enum ClassType {
    case figther
    case magus
    case dwarf
    case colosse
}
//mother class for class Combattant, Magus, Dwarf, Colosse
class Character {
    
    let name: String // name of the characters
    var weapon: Weapon //character's weapon
    var life: Decimal //life of character details in class girl
    let maxLife: Decimal //constant to block over healing and avoid to pass under 0
    var crit: Int //bonus var to multiply the hit by 2
    let type: String //character type or race
    let classType: ClassType //names of class girl
    
    init(name: String, weapon: Weapon, crit: Int,type: String, maxLife: Decimal, classType: ClassType) {
        self.name = name
        self.weapon = weapon
        self.crit = crit
        self.type = type
        
        self.maxLife = maxLife
        self.life = maxLife
        self.classType = classType
        
    }
    
    /////////////////////////////
    ////function attack a character in oposent team//////////
    /////////////////////////////
    func attack(characterToAttack: Character) {
        let numberCrit = Int.random(in: 1 ... (100/crit))
        var attackFactor: Decimal = 1.00
        var critFactor: Decimal = 1.00
        
        attackFactor = compareType(characterToAttack: characterToAttack)
        if numberCrit == 1{
            critFactor = 2
            print("your attack has crit !!!")
        }
        characterToAttack.life -=  (weapon.damage * attackFactor * critFactor)
        
        //check if character is dead and say it to player
        IsCharacterDead(character: characterToAttack, attackFactor: attackFactor, critFactor: critFactor)
    }
    //////////////////////////////////////////////////////////
    ////////function check self life and return a boolean//////////////
    //////////////////////////////////////////////////////////
    func checkCharacterLife() -> Bool{
        return life > 0
    }
    //////////////////////////////////////////////////////////
    ////////function who returns a décimal factor//////////////
    //////////////////////////////////////////////////////////
    func factorType(attackFactorParameter: Decimal) -> Decimal{
        var factor: Decimal = 1
        factor = factor * attackFactorParameter
        print("attack factor : \(factor)")
        return factor
    }
    ///////////////////////////////////
    ///function compare type and return attack factor///
    ///////////////////////////////////
    func compareType (characterToAttack: Character)->Decimal{
        var attackFactor: Decimal = 1.00
        print("Type \(type) vs type \(characterToAttack.type)")
        
        if type == "human" {
            if characterToAttack.type == "elf"{
                attackFactor = factorType(attackFactorParameter: 1.5)
            }
            else{
                if characterToAttack.type == "rock"{
                    attackFactor = factorType(attackFactorParameter: 0.25)
                }
            }
        }
        else{
            if type == "rock"{
                if characterToAttack.type == "human"{
                    attackFactor = factorType(attackFactorParameter: 1.5)
                }
                else{
                    if characterToAttack.type == "elf"{
                        attackFactor = factorType(attackFactorParameter: 1.8)
                    }
                }
            }
            else{
                if type == "elf"{
                    if characterToAttack.type == "rock"{
                        attackFactor = factorType(attackFactorParameter: 0.5)
                    }
                    else{
                        if characterToAttack.type == "human"{
                            attackFactor = factorType(attackFactorParameter: 0.75)
                        }
                    }
                }
            }
        }
        return attackFactor
    }
    ///////////////////////////////////
    ///function print somthing if a character is hit and his life is < 0 ///
    ///////////////////////////////////
    func IsCharacterDead (character: Character, attackFactor: Decimal, critFactor: Decimal){
        
        if self.checkCharacterLife() {
            //security check : is Character to attack alive ?
            if character.checkCharacterLife() {
                print(name + " hit " + character.name)
                //if oponent life < 0 then life = 0
                character.life = max(character.life, 0)
                print(character.name + " loose \(weapon.damage * attackFactor * critFactor) life")
                if character.life <= 0 {
                    print(character.name + " is defeted")
                }
            } else {
                print(character.name + " is dead !")
            }
        } else {
            print(name + "  is dead, choose another")
        }
    }
    
}
