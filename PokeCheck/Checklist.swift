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
    var list: [[Pokemon]]
    
    init() {
        var allPokemonList: [[Pokemon]] = []
        var generationList: [Pokemon] = []
    
//REFACTOR: divide the data by generation, so that the source data is an array of arrays.  Then create pokemon from those array indexes rather than each individual pokemon name
        for pokemonId in 0...pokemonNames.count {
            switch pokemonId {
//0
            case 0...150:
                let pokemon = Pokemon(dexNumber: pokemonId + 1, name: pokemonNames[pokemonId])
                generationList.append(pokemon)
//1
            case 151...250:
                if pokemonId == 151 {
                    allPokemonList.append(generationList)
                    generationList = []
                }
                let pokemon = Pokemon(dexNumber: pokemonId + 1, name: pokemonNames[pokemonId])
                generationList.append(pokemon)
//2
            case 251...385:
                if pokemonId == 251 {
                    allPokemonList.append(generationList)
                    generationList = []
                }
                let pokemon = Pokemon(dexNumber: pokemonId + 1, name: pokemonNames[pokemonId])
                generationList.append(pokemon)
//3
            case 386...492:
                if pokemonId == 386 {
                    allPokemonList.append(generationList)
                    generationList = []
                }
                let pokemon = Pokemon(dexNumber: pokemonId + 1, name: pokemonNames[pokemonId])
                generationList.append(pokemon)
 //4
            case 493...648:
                if pokemonId == 493 {
                    allPokemonList.append(generationList)
                    generationList = []
                }
                let pokemon = Pokemon(dexNumber: pokemonId + 1, name: pokemonNames[pokemonId])
                generationList.append(pokemon)
//5
            case 649...pokemonNames.count - 1: //721:
                if pokemonId == 649 {
                    allPokemonList.append(generationList)
                    generationList = []
                }
                    let pokemon = Pokemon(dexNumber: pokemonId + 1, name: pokemonNames[pokemonId])
                    generationList.append(pokemon)

                if pokemonId == pokemonNames.count - 1 {
                    allPokemonList.append(generationList)
                    generationList = []
                }

            default:
                print("\(pokemonId) was not added")
            }
        }
        
        self.list = allPokemonList
    }
    
    private func fetchAllPokemon() {
        
    }
    private func fetchPokemon(byId: Int){
        
    }
    private func fetchPokemon(byName: String){
        
    }
    
//    func filterBy(_ generation: Generation) -> [Pokemon] {
//        var filteredList = [Pokemon]()
//
//        switch generation {
//            case .RedBlueYellow:
//                for pokemonId in 1...151 {
//                    filteredList.append(list[pokemonId])
//                }
//                print(filteredList)
//                
//                return filteredList
//            case .GoldSilverCrystal:
//                for pokemonId in 152...251 {
//                    filteredList.append(list[pokemonId])
//                }
//                print(filteredList)
//                
//                return filteredList
//            case .RubySaphireEmerald, .FireRedLeafGreen:
//                for pokemonId in 252...386 {
//                    filteredList.append(list[pokemonId])
//                }
//                print(filteredList)
//                
//                return filteredList
//            case .DiamondPearlPlatinum, .HeartGoldSoulSilver:
//                for pokemonId in 387...493 {
//                    filteredList.append(list[pokemonId])
//                }
//                print(filteredList)
//                
//                return filteredList
//            case .BlackWhite:
//                for pokemonId in 494...649 {
//                    filteredList.append(list[pokemonId])
//                }
//                print(filteredList)
//                
//                return filteredList
//            case .XY, .OmegaRubyAlphaSaphire:
//                for pokemonId in 650...721 {
//                    filteredList.append(list[pokemonId])
//                }
//                print(filteredList)
//                
//                return filteredList
////            case .SunMoon
////                for pokemonId in 722...000 {
////                    filteredList.append(list[pokemonId])
////                }
////                print(filteredList)
////                
////                return filteredList
//        }
//    }
}
