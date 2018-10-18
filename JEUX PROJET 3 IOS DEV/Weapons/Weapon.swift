//
//  Weapon.swift
//  JEUX PROJET 3 IOS DEV
//
//  Created by Pyran on 18/09/2018.
//  Copyright © 2018 Spirox. All rights reserved.
//

import Foundation

class Weapon {
    
    var damage: Decimal
    var heal: Decimal
    
    init(damage: Decimal, heal: Decimal) {
        self.damage = damage
        self.heal = heal
    }
}
