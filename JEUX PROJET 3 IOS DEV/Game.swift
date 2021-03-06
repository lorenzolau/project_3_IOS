//
//  Play.swift
//  JEUX PROJET 3 IOS DEV
//
//  Created by Pyran on 21/09/2018.
//  Copyright © 2018 Spirox. All rights reserved.
//

import Foundation
//Principal class create teams and characters and prepare the fight beetwen 2 teams
class Game{
    let firstTeam = Team() // team for first player
    let secondTeam = Team() //team for second player
    var charactersNames = [String]() //array only for including names created from players to check if they are double
    var teamChoice: Int = 0 //index for the team who's playing
    var teamWhoFight: Team // team who is fighting
    var teamWhoReceive: Team  // team who is recieving damages
    var isBothTeamsAlive: Bool = true //boolean var for continue the fight
    var numberOfRounds = 0 //stak in var nb of rounds for display it at the and of game
    
    init() {
        self.teamWhoFight = firstTeam
        self.teamWhoReceive = secondTeam
    }
    
    ///////////////////////////////////////////////
    //////////// general function to create teams and start the fight  //////////////////
    ///////////////////////////////////////////////
    func play(){
        for teamNb in 1...2 {
            //call function createam to create 2 teams
            createTeam(item: teamNb)
        }
        fight()
        print("Number of round : \(numberOfRounds)")
        print("End of game, thanks for playing")
    }
    //////////////////////////////////////////////////////
    ////////////   function create 2 teams   ///////////////
    //////////////////////////////////////////////////////
    func createTeam(item: Int) {
        
        var teamname = ""
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
        printDescritpion(item: item)
    }
    //////////////////////////////////////////////////////
    ////////////principal fighting function to call func attack and declare winner///////////////
    //////////////////////////////////////////////////////
    func fight(){
        selectTeam()
        repeat{
            var figtherCaracter: Character
            teamWhoFight.charactersDisplay()
            print("Select a Character from team : \(teamWhoFight.name) to fight")
            
            let userChoice = selectCharacterAlive(team: teamWhoFight)
            figtherCaracter = teamWhoFight.charactersInTeam[userChoice-1]
            print("charcater choosen : \(figtherCaracter.name) from team \(teamWhoFight.name)")
            let randomNumberForChest = Int.random(in: 1 ... 10)
            if figtherCaracter is Magus{
                PerformHeal(indexChest: randomNumberForChest, magus: figtherCaracter as! Magus)
            }
            else{
                PerformAttack(indexChest: randomNumberForChest, character: figtherCaracter )
            }
            switchTeam()
            //check team life, if all characters are dead in one team, return false and exit while
            declareWinner(teamWhoReceive: teamWhoReceive, teamWhoFight: teamWhoFight)
            numberOfRounds += 1
        }while  isBothTeamsAlive == true
    }
    
    //////////////////////////////////
    //function to switch to another team each round
    //////////////////////////////////
    func switchTeam(){
        if teamChoice == 1 {
            teamChoice = 2
            teamWhoFight = secondTeam
            teamWhoReceive = firstTeam
        }else if teamChoice == 2 {
            teamChoice = 1
            teamWhoFight = firstTeam
            teamWhoReceive = secondTeam
        }
        print("////////////////////////////////////")
    }
    //////////////////////////////////
    //function for select team who act for begin the fight
    //////////////////////////////////
    func selectTeam() {
        //you can select a team who bigin the fight, (maybe random in next version)
        print("////////////////////////////////////")
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
    //function if an other character is choosen, not magus and prepare attack////
    //////////////////////////////////////////////////////////
    func PerformAttack(indexChest:Int, character: Character){
        var characterToAttack: Character
        print("You can choose a character to hit from oposent team \(teamWhoReceive.name):")
        teamWhoReceive.charactersDisplay()
        let userChoice = selectCharacterAlive(team: teamWhoReceive)
        characterToAttack = teamWhoReceive.charactersInTeam[userChoice-1]
        //random number to discover a chest and change the character's weapon
        if  indexChest == 5{
            print("A new weapon is for you \(character.name) : A Mystic weapon who deals 50 damages for all the time")
            character.weapon = Mysticweapon()
        }
        character.attack(characterToAttack: characterToAttack)
    }
    //////////////////////////////////////////////////////////
    //function if magus is selected and prepare the heal////
    //////////////////////////////////////////////////////////
    func PerformHeal(indexChest:Int, magus: Magus){
        var characterToHeal: Character
        print("You can choose a character to hit from oposent team \(teamWhoFight.name):")
        teamWhoFight.charactersDisplay()
        let userChoice = selectCharacterAlive(team: teamWhoFight)
        characterToHeal = teamWhoFight.charactersInTeam[userChoice-1]
        //random number to discover a chest and change the character's weapon
        if indexChest == 5{
            print("A new weapon is for you \(magus.name) : A Big Stick who heals 50 life points")
            magus.weapon = Bigstick()
        }
        magus.heal(characterToHeal: characterToHeal)
    }
    ////////////////////////////////////////////////////////
    //function to return userchoice if character is alive///
    ///////////////////////////////////////////////////////
    func selectCharacterAlive (team: Team)->Int{
        //repeat here the choice if character choosen is dead
        var isCharacterAlive: Bool = false
        var userChoice: Int
        repeat {
            userChoice = Read().selectValueUnder(index: 3)
            if team.charactersInTeam[userChoice-1].life > 0{
                isCharacterAlive = true
            }
            else{
                isCharacterAlive = false
                print("You cannot choose a dead character! Choose another")
            }
        } while !isCharacterAlive
        return userChoice
    }
    //////////////////////////////////
    //function who returns the user string while is not empty
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
    //function for testing if name exist
    //////////////////////////////////
    func getUniqueName (index: Int) -> String{
        var characterName: String
        var isNewValueAdded: Bool = false
        
        print("Enter a name for character n°\(index)")
        repeat {
            characterName = getNotEmptyString()
            if (charactersNames.contains(characterName)){
                print("The name \(characterName) already exist")
            }
            else{
                charactersNames.append(characterName)
                isNewValueAdded = true
            }
        } while !isNewValueAdded
        return characterName
    }
    //////////////////////////////////
    // function swich for add a character in a team
    //////////////////////////////////
    func addCharacterInTeam(itemChoice: Team, characterName: String, userChoice: Int){
        switch userChoice {
        case 1:
            let character = Combattant(name: characterName)
            itemChoice.charactersInTeam.append(character)
        case 2:
            let character = Magus(name: characterName)
            itemChoice.charactersInTeam.append(character)
        case 3:
            let character = Dwarf(name: characterName)
            itemChoice.charactersInTeam.append(character)
        case 4:
            let character = Colosse(name: characterName)
            itemChoice.charactersInTeam.append(character)
        default:
            break
        }
    }
    /////////////////////////////////////////////////
    //////// function to describe and select character to create the team///////
    /////////////////////////////////////////////////
    func printDescritpion(item: Int){
        for i in 1...3 {
            print("Select character n°\(i)")
            print("1 - Figther (use a sword who deals 10 damages and his type is human, he has 100 life)")
            print("2 - Magus (use a stick who heals for 10 life points and his type is an elf, he has 55 life)")
            print("3 - Dwarf (use a Hax who deals 18 damages, his type is human, he has 65 life")
            print("4 - Colosse (use his hands who deals 6 damages, his type is rock, he has 150 life)")
            let userChoice = Read().selectValueUnder(index: 4)
            let characterName = getUniqueName(index : i)
            if item == 1 {
                addCharacterInTeam(itemChoice: firstTeam, characterName: characterName, userChoice: userChoice)
            }
            else{
                addCharacterInTeam(itemChoice: secondTeam, characterName: characterName, userChoice: userChoice)
            }
        }
    }
    //////////////////////////////////
    //function declare winner team////////
    //////////////////////////////////
    func declareWinner(teamWhoReceive: Team, teamWhoFight: Team){
        if !(teamWhoReceive.isTeamAlife()){
            print("All the characters in team \(teamWhoReceive.name) are dead ! \(teamWhoFight.name) has won! Congrats")
            isBothTeamsAlive = false
        }else if !(teamWhoFight.isTeamAlife()){
            print("All the characters in team \(teamWhoFight.name) are dead ! \(teamWhoReceive.name) has won! Congrats")
            isBothTeamsAlive = false
        }
    }
}

