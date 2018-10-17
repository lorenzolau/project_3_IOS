//
//  Read.swift
//  JEUX PROJET 3 IOS DEV
//
//  Created by Pyran on 19/09/2018.
//  Copyright © 2018 Spirox. All rights reserved.
//

import Foundation
// création de l'objet read pour la saisie utilisateur pour un int et un string

class Read {
    
    func ReadString() -> String{
        
        guard let dataString = readLine() else { return "" }
        return dataString
    }
    
    func ReadInt() -> Int{
        
        guard let dataInt = readLine() else { return 0 }
        guard let datatransformInt = Int(dataInt) else { return 0 }
        return datatransformInt
    }
    
}
