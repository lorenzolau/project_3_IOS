//
//  Colosse.swift
//  JEUX PROJET 3 IOS DEV
//
//  Created by Pyran on 19/09/2018.
//  Copyright © 2018 Spirox. All rights reserved.
//

import Foundation

class Colosse: Character{
    
     init(name: String) {
        super.init(name: name, weapon: Hand(), armor: 100,type: Typeofcharacter.Colosse, max_life: 150)
    }
    
}