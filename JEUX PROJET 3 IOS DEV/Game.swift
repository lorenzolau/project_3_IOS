//
//  Play.swift
//  JEUX PROJET 3 IOS DEV
//
//  Created by Pyran on 21/09/2018.
//  Copyright © 2018 Spirox. All rights reserved.
//

import Foundation

class Game{
    //var and constant definition
    let firstTeam = Team()
    let secondTeam = Team()
    var characterNotDouble = [String]() //array with characters
    var choice = 0 //player choice
    var characterName = "" //character name
    var teamChoice: Int = 0 //for choosing team initialize
    var teamWhoFight: Team //select team who's fighting
    var teamWhoReceive: Team  //select team who's recieving damages
    var bool: Bool = true //boolean var for repeat the fight
    var lifecheck: Int = 0 //use for bigening the fight and never choose a dead character
    var count = 0
    
    init() {
        self.teamWhoFight = firstTeam
        self.teamWhoReceive = secondTeam
    }
    
    ///////////////////////////////////////////////
    ////////////  function play  //////////////////
    ///////////////////////////////////////////////
    func play(){
        for teamNb in 1...2 {
            //call function createam to create 2 teams
            createTeam(item: teamNb)
        }
        //call function fight
        fight()
        print("Number of round : \(count)")
        print("End of game, thanks for playing")
    }
    //////////////////////////////////////////////////////
    ////////////   function create teams   ///////////////
    //////////////////////////////////////////////////////
    func createTeam(item: Int) {
        
        // characters.removeAll() //remove array for creating 2th team
        var teamname = "" //name of the team
        print("Input team name n°\(item)")
        repeat{
            let read = Read()
            teamname = read.ReadString()
        }while teamname == ""
        if (firstTeam.name == ""){
            firstTeam.name = teamname
        }
        else{
            secondTeam.name = teamname
        }
        printDescritpion(item: item) // description of characters to make a choice for players
        //team.charactersInTeam = characters // add characters in team
        // teams.append(firstTeam)  // add team in array
    }
    //////////////////////////////////////////////////////
    ////////////principal fighting function///////////////
    //////////////////////////////////////////////////////
    func fight(){
        selectTeam()
        repeat{
            var figtherCaracter: Character
            teamWhoFight.charactersDisplay()
            print("Select a Character from team : \(teamWhoFight.name) to fight")
            choice = Read().selectValueUnder(index: 3)
            figtherCaracter = teamWhoFight.charactersInTeam[choice-1]
            //check if character choosen is dead
            checkRecieverLife(reciver: figtherCaracter)
            figtherCaracter = teamWhoFight.charactersInTeam[choice-1]
            print("charcater choosen : \(figtherCaracter.name) from team \(teamWhoFight.name)")
            let randomNumberForChest = Int.random(in: 1 ... 10)
            if figtherCaracter is Magus{
                if selectMagus(index_chest: randomNumberForChest, figtherCaracter: figtherCaracter as! Magus) != nil{}
            }
            else{
                if selectCharacter(index_chest: randomNumberForChest, figtherCaracter: figtherCaracter ) != nil{}
            }
            select_choice()
            //check team life if all characters are dead return false and exit while
            if !(teamWhoReceive.check_life()){
                print("All the characters in team \(teamWhoReceive.name) are dead ! \(teamWhoFight.name) has won! Congrats")
                bool = false
            }else if !(teamWhoFight.check_life()){
                print("All the characters in team \(teamWhoFight.name) are dead ! \(teamWhoReceive.name) has won! Congrats")
                bool = false
            }
            count += 1
        }while  bool == true
    }
    //////////////////////////////////
    //function select team choice
    //////////////////////////////////
    func select_choice(){
        //select other team
        if teamChoice == 1 {
            teamChoice = 2
            teamWhoFight = secondTeam
            teamWhoReceive = firstTeam
        }else if teamChoice == 2 {
            teamChoice = 1
            teamWhoFight = firstTeam
            teamWhoReceive = secondTeam
        }
    }
    //////////////////////////////////
    //function for select team who act
    //////////////////////////////////
    func selectTeam() {
        //you can select a team who bigin the fight, (maybe random in next version)
        print("Select a team ")
        print("1 - \(firstTeam.name)")
        print("2 - \(secondTeam.name)")
        teamChoice = Read().selectValueUnder(index: 2)
        if teamChoice == 1 {
            teamWhoFight = firstTeam
            teamWhoReceive = secondTeam
        }else if teamChoice == 2 {
            teamWhoFight = secondTeam
            teamWhoReceive = firstTeam
        }
        print("You have selected team : \(teamWhoFight.name)")
        print("Discover the list :")
    }
    //////////////////////////////////////////////////////////
    //function if an other character is choosen, not magus////
    //////////////////////////////////////////////////////////
    func selectCharacter(index_chest:Int, figtherCaracter: Character)-> Character?{
        var characterToAttack: Character
        
        if figtherCaracter.life > 0 {
            print("You can choose a character to hit from oposent team \(teamWhoReceive.name):")
            teamWhoReceive.charactersDisplay()
            choice = Read().selectValueUnder(index: 3)
            characterToAttack = teamWhoReceive.charactersInTeam[choice-1]
            
            if  index_chest == 5{
                print("A new weapon is for you \(figtherCaracter.name) : A Mystic weapon who deals 50 damages for all the time")
                figtherCaracter.weapon = Mysticweapon()
            }
            
            checkRecieverLife(reciver: characterToAttack)
            figtherCaracter.attack(who: characterToAttack)
            return characterToAttack
        }else{
            print("You cannot choose a dead character!")
            return nil
        }
    }
    //////////////////////////////////////////////////////////
    //function if magus is selected////
    //////////////////////////////////////////////////////////
    func selectMagus(index_chest:Int, figtherCaracter: Magus)-> Character?{
        var characterToHeal: Character
        
        if figtherCaracter.life > 0 {
            print("You can choose a character to hit from oposent team \(teamWhoFight.name):")
            teamWhoFight.charactersDisplay()
            choice = Read().selectValueUnder(index: 3)
            characterToHeal = teamWhoFight.charactersInTeam[choice-1]
            
            if index_chest == 5{
                print("A new weapon is for you \(figtherCaracter.name) : A Big Stick who heals 50 life points")
                figtherCaracter.weapon = Bigstick()
            }
            checkRecieverLife(reciver: characterToHeal)
            figtherCaracter.heal(who: characterToHeal)
            return characterToHeal
        }else{
            print("You cannot choose a dead character!")
            return nil
        }
    }
    //////////////////////////////////////////
    //function to check if reciver is alive///
    //////////////////////////////////////////
    func checkRecieverLife (reciver: Character){
        //repeat here the choice if character choosen is dead
        repeat {
            if reciver.life > 0{
                lifecheck = 1
            }
            else{
                print("You cannot choose a dead character! Choose another")
                choice = Read().selectValueUnder(index: 3)
            }
        } while lifecheck != 1
    }
    //////////////////////////////////
    //function for testing if name is double
    //////////////////////////////////
    func getNotEmptyString() -> String {
        var userEntry: String
        repeat{
            let read = Read()
            userEntry = read.ReadString()
        } while userEntry == ""
        return userEntry
    }
    //////////////////////////////////
    //function for testing if name is double
    //////////////////////////////////
    func nameNotDouble (i: Int){
        var isNewValueAdded: Bool = false
        
        print("Enter a name for character n°\(i)")
        repeat {
            characterName = getNotEmptyString()
            if (characterNotDouble.contains(characterName)){
                print("The name \(characterName) already exist")
            }
            else{
                characterNotDouble.append(characterName)
                isNewValueAdded = true
            }
        } while isNewValueAdded == false
    }
    //////////////////////////////////
    // function swich for add a character in a team
    //////////////////////////////////
    func addCharactersInTeam(itemChoice: Team){
        switch choice {
        case 1:
            let i = Combattant(name: characterName)
            itemChoice.charactersInTeam.append(i)
        case 2:
            let i = Magus(name: characterName)
            itemChoice.charactersInTeam.append(i)
        case 3:
            let i = Dwarf(name: characterName)
            itemChoice.charactersInTeam.append(i)
        case 4:
            let i = Colosse(name: characterName)
            itemChoice.charactersInTeam.append(i)
        default:
            break
        }
    }
    /////////////////////////////////////////////////
    //////// function description and print it///////
    /////////////////////////////////////////////////
    func printDescritpion(item: Int){
        var teamTurn: Team
        if item == 1 {
            teamTurn = firstTeam
        }
        else{
            teamTurn = secondTeam
        }
        for i in 1...3 {
            print("Select character n°\(i)")
            print("1 - Figther (use a Sword who deals 10 damages and his type is human, he has  100 life)")
            print("2 - Magus (use a stick who heals for 10 life points and his type is an elf, he has 55 life)")
            print("3 - Dwarf (use a Hax who deals 18 damages, his type is human, he has 65 life")
            print("4 - Colosse (use his hands who deals 6 damages, his type is rock, he has 150 life)")
            //function readline for choice 1 to 4, and nothing else
            choice = Read().selectValueUnder(index: 4)
            //check if name is double
            nameNotDouble(i : i)
            //switch for adding what kind of character is choosen in array
            addCharactersInTeam(itemChoice: teamTurn)
        }
    }
}
