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
    var allPokemon: [PokemonKit.PKMNamedAPIResource]?

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        PokemonKit.fetchPokemonForm("2").then {
//            berryInfo in
//                print(berryInfo.sprites?.frontDefault)
//            }
        
        getAllPokemon()
        
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
        if allPokemon == nil {
            return 1
        }
        
        return (allPokemon?.count)!
    }
    override func collectionView(collectionView: UICollectionView,
                                 cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokemonCell", forIndexPath: indexPath) as! PokemonCell
        return cell
    }
    override func collectionView(collectionView: UICollectionView,
                                 didSelectItemAtIndexPath indexPath: NSIndexPath) {
    }
}


//POKEMON Stuff
extension ChecklistViewController {
    
    func getAllPokemon() {
        fetchPokemons().then{
            allPokemons in
            self.allPokemon = allPokemons.results
            print("Done!")
            self.collectionView?.reloadData()
        }
    }
}

