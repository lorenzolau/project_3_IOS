//
//  Play.swift
//  JEUX PROJET 3 IOS DEV
//
//  Created by Pyran on 21/09/2018.
//  Copyright © 2018 Spirox. All rights reserved.
//

import Foundation

class Play{
    //var and constant definition
    var teams = [Team]()
    var characterNamedouble = "" //is character name already exist?
    var character_not_double = [String]() //array with characters
    var choice = 0 //player choice
    var characterName = "" //character name
    var team_choice: Int = 0 //for choosing team initialize
    var team_who_fight: Int = 0 //select team who's fighting
    var team_who_receive: Int = 0 //select team who's recieving damages
    var bool: Bool = true //boolean var for repeat the fight
    var lifecheck: Int = 0 //use for bigening the fight and never choose a dead character
    var characters = [Character]() //character list in array
    
    
    func play(){
       
//  creat Team with function createteam()
    for team_nb in 1...2 {
        createteam(tnb: team_nb)
        }
        //call function fight
       fight()
    }
    //////////////////////////////////////////////////////
    ////////////   function create teams   ///////////////
    //////////////////////////////////////////////////////
    func createteam(tnb: Int) {
        //remove array characters for 2th team
        characters.removeAll()
        
        let team = Team()
        //let characters_definiton = Combattant()
        var teamname = "" //name of the team
        print("Input your team name n°\(tnb)")
    repeat{
        let read = Read()
        teamname = read.ReadString()
    }while teamname == ""
    
    team.name = teamname
    
        print_descritpion()
        
        team.characters_in_team = characters // add characters in team
        teams.append(team)  // add team in array
    }
    //////////////////////////////////////////////////////
    ////////////principal fighting function///////////////
    //////////////////////////////////////////////////////
    func fight(){
    //select a team with function
    select_team()
        repeat{
            var figther_caracter: Character       // Character who fight
           // var reciver_caracter: Character       // Character who recive
            //call function to display character in team who is choosen
            teams[team_who_fight].characters_display()
            //select character in team
            print("Select a Character from team : \(teams[team_who_fight].name) ")
            //function readline for select a character in team
            read_choice()
            //put the character who's choosen in var figther_caracter
            figther_caracter = teams[team_who_fight].characters_in_team[choice-1]
            //check if character choosen is dead
            repeat {
                // à sortir
                if figther_caracter.life > 0{
                    lifecheck = 1
                }
                else{
                    print("You cannot choose a dead character! Choose another")
                    read_choice()
                    //put the character who's choosen in var
                    figther_caracter = teams[team_who_fight].characters_in_team[choice-1]
                }
            } while lifecheck != 1
            print("charcater choosen : \(figther_caracter.name)")
            // a random number for new weapon 10% chance
            let random_chest = Int.random(in: 1 ... 10)
            // if magus then select a team character to heal, he cannot attack
            if let magus = figther_caracter as? Magus {
                if if_magus(index_coffre: random_chest, magus: magus, figther_caracter: figther_caracter ) != nil{
                  
                }
            }else{ // if not magus then select a character in oposent team
                if if_not_magus(index_chest: random_chest, figther_caracter: figther_caracter ) != nil{
                
                }
            }
            //select other team
            select_choice()
            //check team life if all characters are dead return false and exit while
            if !(teams[team_who_receive].check_life()){
                print("All the characters in team \(teams[team_who_receive].name) are dead ! \(teams[team_who_fight].name) has won! Congrats")
                bool = false
            }else if !(teams[team_who_fight].check_life()){
                print("All the characters in team \(teams[team_who_fight].name) are dead ! \(teams[team_who_receive].name) has won! Congrats")
                bool = false
            }
        }while  bool == true
    }
    //////////////////////////////////
    //function select team choice
    //////////////////////////////////
    func select_choice(){
        //select other team
        if team_choice == 1 {
            team_choice = 2
            team_who_fight = 1
            team_who_receive = 0
        }else if team_choice == 2 {
            team_choice = 1
            team_who_fight = 0
            team_who_receive = 1
        }
    }
    //////////////////////////////////
    // function read choice for 3 choices
    //////////////////////////////////
    func read_choice (){
        repeat {
            let read = Read()
            choice = read.ReadInt()
        } while choice != 1 && choice != 2 && choice != 3
    }
    //////////////////////////////////
    //function read choice for 4 choices
    //////////////////////////////////
    func read_choice_4 (){
        repeat {
            let read = Read()
            choice = read.ReadInt()
        } while choice != 1 && choice != 2 && choice != 3 && choice != 4
    }
    //////////////////////////////////
    //function for select team who act
    //////////////////////////////////
    func select_team() {
        //you can select a team who bigin the fight, (maybe random in next version)
        print("Select a team ")
        print("1 - \(teams[0].name)")
        print("2 - \(teams[1].name)")
        repeat {
            let read = Read()
            team_choice = read.ReadInt()
        } while team_choice != 1 && team_choice != 2
        if team_choice == 1 {
            // change var team who fight and recieve 1 or 0
            team_who_fight = 0
            team_who_receive = 1
            
        }else if team_choice == 2 {
            // change var team who fight and recieve 1 or 0
            team_who_fight = 1
            team_who_receive = 0
        }
        print("You have selected team : \(teams[team_who_fight].name)")
        print("Discover the list :")
    }
    //////////////////////////////////
    ///function if magus is selected//
    //////////////////////////////////
    func if_magus (index_coffre: Int, magus: Magus, figther_caracter: Character) -> Character?{
        var character_to_return: Character
        //if var index_coffre = 5 a the random number 1 to 10 then give a bigstick weapon to magus
        if index_coffre == 5 {
            print("A new weapon is for you :  \(figther_caracter.name)")
            figther_caracter.weapon = Bigstick()
        }
        // check if magus is alive
        if magus.life > 0 {
            print("You can choose a character to heal from your team :")
            //select a character to heal
            teams[team_who_fight].characters_display()
            read_choice()
            character_to_return = teams[team_who_fight].characters_in_team[choice-1]
            //function to check if the reciever character is alive
            check_life_reciever(reciver: character_to_return)
            //magus heal a team character choosen
            magus.healing(who: character_to_return)
            return character_to_return
        }
        else{
            print("You cannot choose a dead character!")
            return nil
            }
    }
    //////////////////////////////////////////////////////////
    //function if an other character is choosen, not magus////
    //////////////////////////////////////////////////////////
    func if_not_magus(index_chest:Int, figther_caracter: Character)-> Character?{
        var character_to_attack: Character
        //if random number
        if index_chest == 5 {
            print("A new weapon is for you :  \(figther_caracter.name)")
            figther_caracter.weapon = Mysticweapon()
        }
        //if character is alife
        if figther_caracter.life > 0 {
        // else select a oponent
        print("You can choose a character to hit from oposent team \(teams[team_who_receive].name):")
        teams[team_who_receive].characters_display()
        read_choice()
        //put the choice in var reciver_caracter
        character_to_attack = teams[team_who_receive].characters_in_team[choice-1]
        //function to check if the reciever character is alive
        check_life_reciever(reciver: character_to_attack)
        //put the character who's choosen in var
        character_to_attack = teams[team_who_fight].characters_in_team[choice-1]
        //call attack function in class Character and begin the fight between 2 choosen characters
        figther_caracter.attack(who: character_to_attack)
        return character_to_attack
        }else{
            print("You cannot choose a dead character!")
            return nil
        }
    }
    //////////////////////////////////////////
    //function to check if reciver is alive///
    //////////////////////////////////////////
    func check_life_reciever (reciver: Character){
    //repeat here the choice if character choosen is dead
    repeat {
    if reciver.life > 0{
    lifecheck = 1
    }
    else{
    print("You cannot choose a dead character! Choose another")
    read_choice()
    }
    } while lifecheck != 1
    }
    //////////////////////////////////
    //function for testing if name is double
    //////////////////////////////////
    func name_not_double (i: Int){
        print("Enter a name for character n°\(i)")
        characterName = ""
        repeat {
            repeat{
                let read = Read()
                characterNamedouble = read.ReadString()
                   } while characterNamedouble == ""
            if (character_not_double.contains(characterNamedouble)){
                print("The name \(characterNamedouble) already exist")
                }
            else{
                characterName = characterNamedouble
                character_not_double.append(characterName)
                }
                } while characterName == ""
    }
    //////////////////////////////////
    // function swich for add a character in a team
    //////////////////////////////////
    func swich_choice(){
        switch choice {
        case 1:
            let i = Combattant(name: characterName)
            characters.append(i)
        case 2:
            let i = Magus(name: characterName)
            characters.append(i)
        case 3:
            let i = Dwarf(name: characterName)
            characters.append(i)
        case 4:
            let i = Colosse(name: characterName)
            characters.append(i)
        default:
            break
        }
    }
    /////////////////////////////////////////////////
    //////// function description and print it///////
    /////////////////////////////////////////////////
    func print_descritpion(){
    for i in 1...3 {
    print("Select character n°\(i)")
    print("1 - Figther (use a Sword who deals 10 damages and his type is human, he has  100 life)")
    print("2 - Magus (use a stick who heals for 10 life points and his type is an elf, he has 55 life)")
    print("3 - Dwarf (use a Hax who deals 18 damages, his type is human, he has 65 life")
    print("4 - Colosse (use his hands who deals 6 damages, his type is rock, he has 150 life)")
    //function readline for choice 1 to 4, and nothing else
    read_choice_4()
    //check if name is double
    name_not_double(i : i)
    //switch for adding what kind of character is choosen in array
    swich_choice()
    }
    }
}

