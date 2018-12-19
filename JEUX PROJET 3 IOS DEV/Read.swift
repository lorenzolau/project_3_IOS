//
//  Read.swift
//  JEUX PROJET 3 IOS DEV
//
//  Created by Pyran on 19/09/2018.
//  Copyright © 2018 Spirox. All rights reserved.
//

import Foundation
////////////////////////////////////////////////
// class Read with 2 functions to read the value choosen and return an int or string
///////////////////////////////////////////////
class Read {
    
    func ReadString() -> String{
        
        guard let dataString = readLine() else { return "" }
        return dataString
    }
    ///////////////////////////////////////
    // return a Int under or egal at index with number choosen with readline()
    //////////////////////////////////////
    func selectValueUnder (index: Int) -> Int{
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
