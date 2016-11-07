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
    var list: [Pokemon]
    
    init() {
        self.list = []
        
    }
    
    private func fetchAllPokemon() {
        
    }
    private func fetchPokemon(byId: Int){
        
    }
    private func fetchPokemon(byName: String){
        
    }
    
    func filterBy(_ generation: Generation) -> [Pokemon] {
        var filteredList = list

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
