//
//  Read.swift
//  JEUX PROJET 3 IOS DEV
//
//  Created by Pyran on 19/09/2018.
//  Copyright © 2018 Spirox. All rights reserved.
//

import Foundation
////////////////////////////////////////////////
// create Read object for readline and return an int or string
///////////////////////////////////////////////
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
    ///////////////////////////////////////
    // function userChoice with readline()
    //////////////////////////////////////
    func userChoice (index: Int) -> Int{
        repeat {
            if let read = readLine() {
                if let choice = Int(read){
                    if choice > 0 && choice <= index {
                        return choice
                    }
                }
            }
            print("Make a choice between 1 and \(index)")
        } while true
    }
}
