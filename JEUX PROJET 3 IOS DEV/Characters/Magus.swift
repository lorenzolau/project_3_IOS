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
        super.init(name: name, weapon: Stick(), armor: 25,type: Typeofcharacter.Magus, max_life: 55)
    }
    
    func healing(who: Character) {
        
        who.life += weapon.heal
        
        if who.life > who.max_life {
            
            who.life = who.max_life
            
        }
    }
    
}
