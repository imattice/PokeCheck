//
//  ViewController.swift
//  PokeCheck
//
//  Created by Ike Mattice on 8/16/16.
//  Copyright © 2016 Ike Mattice. All rights reserved.
//

import UIKit
import PokemonKit
import ObjectMapper

class ChecklistViewController: UICollectionViewController {
    var allPokemonSprites: [String] = []
    var allPokemonIDs: [Int?] = []
    var pokemonDict: [String : AnyObject] = [:]
    var allPokemon: [PKMNamedAPIResource] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllPokemonSprites()
        
//        getPokemonID()
        
        //Register nib
        collectionView?.registerNib(UINib(nibName: "PokemonCell", bundle: nil), forCellWithReuseIdentifier: "PokemonCell")
        
        //STYLES: 
        collectionView?.backgroundColor = UIColor.whiteColor()
        }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("recieved Memory warning!!!")
    }
}

//COLLECTION VIEW CONTOLLER FUNCTIONS
extension ChecklistViewController {
    override func collectionView(collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        if allPokemonSprites.isEmpty {
            return 1
        }
        
        return (allPokemonSprites.count)
    }
    override func collectionView(collectionView: UICollectionView,
                                 cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokemonCell", forIndexPath: indexPath) as! PokemonCell
            if allPokemonSprites.isEmpty{
                let dexNumber = indexPath.row + 1
                cell.cellLabel.text = String(dexNumber)
                cell.cellImage.image = UIImage(named: "0")
            } else {
//                _ = allPokemonSprites[indexPath.row]
//                            cell.cellImage.image = pokemon.image
                let dexNumber = indexPath.row + 1
                cell.cellLabel.text = String(dexNumber)
            }
        return cell
    }
    override func collectionView(collectionView: UICollectionView,
                                 didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(allPokemonSprites)
    }
}


//POKEMON Stuff
extension ChecklistViewController {
//    
//    func loopThroughPokemon(pokemon: PKMPokemon, closure: () -> ()) {
//        for _ in 1...5 {
//            let newPokemon = Pokemon()
//            newPokemon.number = pokemon.id
//            newPokemon.name = pokemon.name
//            newPokemon.image = UIImage(data: NSData(contentsOfURL: NSURL(string: (pokemon.sprites?.frontDefault)!)!)!)
//            //                self.pokemonDict["Forms"] = pokemon.forms
//            self.pokemonDict.append(newPokemon)
//            print(self.pokemonDict)
//        }
//        closure()
//    }
    
//    func getPokemonID() {
//        for i in 1...5 {
//            fetchPokemon(String(i)).then{
//                pokemon in
//                print(pokemon)
//            }
//        }
//    }
    
//    PKMPagedObject -> [PKMNamedAPIResource]
//    func getAllPokemon() {
//        fetchPokemons().then{
//            allPokemons in
//            for pokemon in allPokemons.results! {
//                print(pokemon.name)
//                self.allPokemon.append(pokemon)
//            }
//            print(self.allPokemon)
//            self.collectionView?.reloadData()
//        }
//    }
//    PMNPagedObject.results -> [PKMNamedAPIResource.url] -> JSON Object -> "sprites" : {"front_default" : endurl}
    func getAllPokemonSprites() {
        fetchPokemonForms().then{
            allSprites in
                for sprite in allSprites.results! {
                    let spriteURL = NSURL(string: sprite.url!)
                    
                    let pokemonMap = Map(mappingType: .FromJSON, JSONDictionary: self.pokemonDict)
//                    spriteURL.mapping(pokemonMap)
//                    self.parseJSON(fromAPIResults: sprite.url!)
                    print(spriteURL)
                    self.allPokemonSprites.append(sprite.url!)
                }
            print(self.pokemonDict)

//            print(self.allPokemonSprites)
            self.collectionView?.reloadData()
//            print("view did reload")
        }
    }
    
    func parseJSON(fromAPIResults url: String){
        let objectFromURL = NSData(contentsOfURL: NSURL(string: url)!)
        do {
         let json = try NSJSONSerialization.JSONObjectWithData(objectFromURL!, options: NSJSONReadingOptions())
            print(json)
//            print("Front Default: " + json.sprites)
        } catch {
            print(error)
        }
    }
    func getPokemonSprite(fromPokemonURL url: String) {
        
    }
}

