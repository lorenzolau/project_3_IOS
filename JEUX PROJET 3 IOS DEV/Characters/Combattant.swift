//
//  Combattant.swift
//  JEUX PROJET 3 IOS DEV
//
//  Created by Pyran on 19/09/2018.
//  Copyright © 2018 Spirox. All rights reserved.
//

import Foundation

class Combattant: Character {
    
    init(name: String) {
        super.init(name: name, weapon: Sword(), crit: 15,type: "human", maxLife: 100, classType: ClassType.combattant)
    }
}
