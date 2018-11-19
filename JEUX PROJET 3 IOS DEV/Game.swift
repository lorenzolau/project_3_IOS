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
    var firstTeam = Team()
    var secondTeam = Team()
    var characterNotDouble = [String]() //array with characters
    var choice = 0 //player choice
    var characterName = "" //character name
    var teamChoice: Int = 0 //for choosing team initialize
    var teamWhoFight: Team //select team who's fighting
    var teamWhoReceive: Team  //select team who's recieving damages
    var bool: Bool = true //boolean var for repeat the fight
    var lifecheck: Int = 0 //use for bigening the fight and never choose a dead character
    
    init(teamWhoFight: Team, teamWhoReceive: Team) {
        self.teamWhoFight = teamWhoFight
        self.teamWhoReceive = teamWhoReceive
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
        //select a team with function
        selectTeam()
        //fonction demander au joueur 1 de jouer
        //fonction demander au joueur 2 de jouer avec parametre différent
        repeat{
            var figtherCaracter: Character       // Character who fight
            teamWhoFight.charactersDisplay() //call function to display character in team who is choosen
            print("Select a Character from team : \(teamWhoFight.name) to fight")
            choice = Read().selectValueUnder(index: 3)
            figtherCaracter = teamWhoFight.charactersInTeam[choice-1] //put the character who's choosen in var figtherCaracter
            //check if character choosen is dead
            checkRecieverLife(reciver: figtherCaracter)
            figtherCaracter = teamWhoFight.charactersInTeam[choice-1]
            print("charcater choosen : \(figtherCaracter.name) from team \(teamWhoFight.name)")
            // if magus then select a team character to heal, he cannot attack
            let random_chest = Int.random(in: 1 ... 10)  // a random number for new weapon 10% chance
            //  if let magus = figtherCaracter as? Magus {
            //     if magus_selected(index_coffre: random_chest, magus: magus, figtherCaracter: figtherCaracter ) != nil{}
            // }else{
            if selectCharacter(index_chest: random_chest, figtherCaracter: figtherCaracter ) != nil{}
            // }
            //select other team
            select_choice()
            //check team life if all characters are dead return false and exit while
            if !(teamWhoReceive.check_life()){
                print("All the characters in team \(teamWhoReceive.name) are dead ! \(teamWhoFight.name) has won! Congrats")
                bool = false
            }else if !(teamWhoFight.check_life()){
                print("All the characters in team \(teamWhoFight.name) are dead ! \(teamWhoReceive.name) has won! Congrats")
                bool = false
            }
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
            
            if characterToAttack is Magus && index_chest == 5{
                print("A new weapon is for you \(figtherCaracter.name) : A Mystic weapon who deals 50 damages")
                figtherCaracter.weapon = Bigstick()
            }
            else{
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
            let characterNamedouble = getNotEmptyString()
            if (characterNotDouble.contains(characterNamedouble)){
                print("The name \(characterNamedouble) already exist")
            }
            else{
                characterNotDouble.append(characterNamedouble)
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

