//
//  Dwarf.swift
//  JEUX PROJET 3 IOS DEV
//
//  Created by Pyran on 19/09/2018.
//  Copyright © 2018 Spirox. All rights reserved.
//

import Foundation
//class dwarf details herited from Character
class Dwarf: Character {
    
     init(name: String) {
        super.init(name: name, weapon: Hax(), crit: 18,type: "elf", maxLife: 65, classType: .dwarf)
    }
}
