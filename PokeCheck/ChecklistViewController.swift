//
//  ViewController.swift
//  PokeCheck
//
//  Created by Ike Mattice on 8/16/16.
//  Copyright © 2016 Ike Mattice. All rights reserved.
//

import UIKit
import PokemonKit

class ChecklistViewController: UICollectionViewController {
    var allPokemonSprites: [PokemonKit.PKMNamedAPIResource]?
    var allPokemonIDs: [Int?] = []
    var pokemonDict: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        getAllPokemonSprites()
        
        getPokemonID()
        
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
        if allPokemonSprites == nil {
            return 1
        }
        
        return (allPokemonSprites?.count)!
    }
    override func collectionView(collectionView: UICollectionView,
                                 cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokemonCell", forIndexPath: indexPath) as! PokemonCell
        return cell
    }
    override func collectionView(collectionView: UICollectionView,
                                 didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(allPokemonSprites)
    }
}


//POKEMON Stuff
extension ChecklistViewController {
    
    func getPokemonID() {
        for i in 1...5 {
            fetchPokemon(String(i)).then{
                pokemon in
                let newPokemon = Pokemon()
                newPokemon.number = pokemon.id
                newPokemon.name = pokemon.name
                newPokemon.image = UIImage(data: NSData(contentsOfURL: NSURL(string: (pokemon.sprites?.frontDefault)!)!)!)
//                self.pokemonDict["Forms"] = pokemon.forms
                self.pokemonDict.append(newPokemon)
                print(self.pokemonDict)
            }
        }

    }
    
//    func getAllPokemon() {
//        fetchPokemons().then{
//            allPokemons in
//            self.allPokemon = allPokemons.results
//            print("Done!")
//            self.collectionView?.reloadData()
//        }
//    }
    func getAllPokemonSprites() {
        fetchPokedex("1").then{
            allSprites in
            print(allSprites.id)
//                self.allPokemonSprites = allSprites.results
                print("Done!")
                self.collectionView?.reloadData()
        }
    }
}

