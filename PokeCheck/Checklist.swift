//
//  Checklist.swift
//  PokeCheck
//
//  Created by Ike Mattice on 11/6/16.
//  Copyright © 2016 Ike Mattice. All rights reserved.
//

import Foundation

enum FilterType {
    case Generation
    case Name
    case Number
    case Location
}

struct Checklist {
    var allPokemonList: [[Pokemon]]
    var list: [Pokemon]
    
    init() {
        var allPokemonList: [[Int]] = []
        var generationList: [Int] = []

        //loop through all pokemon
        //create first generation dict
        //loop through first generation
            //
                //for each generation, label it and add the pokemon
        
        for pokemonId in 0...pokemonNames.count {
            
            switch pokemonId {
            case 0...151: 
                generationList.append(pokemonId)
            case 152...251:
                if pokemonId == 152 {
                    //print("First gen list: \(generationList)")
                    allPokemonList.append(generationList)
                    print("Current AllPokemonList: \(allPokemonList)")
                    generationList = []
                }
                generationList.append(pokemonId)
            case 252...386:
                if pokemonId == 252 {
                    //print("Second gen list: \(generationList)")
                    allPokemonList.append(generationList)
                    print("Current AllPokemonList: \(allPokemonList)")
                    generationList = []
                }
                generationList.append(pokemonId)
            case 387...492:
                if pokemonId == 387 {
                    //print("Third gen list: \(generationList)")
                    allPokemonList.append(generationList)
                    print("Current AllPokemonList: \(allPokemonList)")
                    generationList = []
                }
                generationList.append(pokemonId)
            case 493...649:
                if pokemonId == 493 {
                    allPokemonList.append(generationList)
                    generationList = []
                }
                generationList.append(pokemonId)
            case 650...721:
                if pokemonId == 650 {
                    allPokemonList.append(generationList)
                    generationList = []
                }
                generationList.append(pokemonId)
            case 722...pokemonNames.count:
                if pokemonId == 722 {
                    allPokemonList.append(generationList)
                    generationList = []
                }
                generationList.append(pokemonId)
            
                if pokemonId == pokemonNames.count {
                    self.allPokemonList = allPokemonList
                }
            default:
                print("didn't work")
            }
                
            //print("pokemonId: \(pokemonId)")
        }

        self.list = []
        
        print("Pokemon list: \(self.allPokemonList)")

    }
    
    private func fetchAllPokemon() {
        
    }
    private func fetchPokemon(byId: Int){
        
    }
    private func fetchPokemon(byName: String){
        
    }
    
    func filterBy(_ generation: Generation) -> [Pokemon] {
        var filteredList = [Pokemon]()

        switch generation {
            case .RedBlueYellow:
                for pokemonId in 1...151 {
                    filteredList.append(list[pokemonId])
                }
                print(filteredList)
                
                return filteredList
            case .GoldSilverCrystal:
                for pokemonId in 152...251 {
                    filteredList.append(list[pokemonId])
                }
                print(filteredList)
                
                return filteredList
            case .RubySaphireEmerald, .FireRedLeafGreen:
                for pokemonId in 252...386 {
                    filteredList.append(list[pokemonId])
                }
                print(filteredList)
                
                return filteredList
            case .DiamondPearlPlatinum, .HeartGoldSoulSilver:
                for pokemonId in 387...493 {
                    filteredList.append(list[pokemonId])
                }
                print(filteredList)
                
                return filteredList
            case .BlackWhite:
                for pokemonId in 494...649 {
                    filteredList.append(list[pokemonId])
                }
                print(filteredList)
                
                return filteredList
            case .XY, .OmegaRubyAlphaSaphire:
                for pokemonId in 650...721 {
                    filteredList.append(list[pokemonId])
                }
                print(filteredList)
                
                return filteredList
//            case .SunMoon
//                for pokemonId in 722...000 {
//                    filteredList.append(list[pokemonId])
//                }
//                print(filteredList)
//                
//                return filteredList
        }
    }
}
