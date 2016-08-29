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
//    var allPokemon: [PKMNamedAPIResource] = []
    var allPokemon: [Pokemon] = []
    
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
        if allPokemon.isEmpty {
            return 1
        }
        
        return (allPokemon.count)
    }
    override func collectionView(collectionView: UICollectionView,
                                 cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokemonCell", forIndexPath: indexPath) as! PokemonCell
        
        
        if allPokemon.isEmpty{
                let dexNumber = indexPath.row + 1
                cell.cellLabel.text = String(dexNumber)
                cell.cellImage.image = UIImage(named: "0")
            } else {
                let pokemon = allPokemon[indexPath.row]
//                            cell.cellImage.image = pokemon.image
                if let pokemonID = pokemon.number {
                    cell.cellLabel.text = String(pokemonID)
                }
            print(pokemon.number)
//                cell.cellImage.image = pokemon.sprite
            }
        return cell
    }
    override func collectionView(collectionView: UICollectionView,
                                 didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Hello")
    }
}


//POKEMON Stuff
extension ChecklistViewController {
///    PMNPagedObject.results -> [PKMNamedAPIResource.url] -> JSON Object -> "sprites" : {"front_default" : endurl}
    func getAllPokemonSprites() {
        fetchPokemonForms().then{
//            allSprites => PKMPagedObject(count, next, previous, results, init(), mapping())
            allSprites in
//                allSprites => [PKMNamedAPIResource]?
//                sprite => PKMNamedAPIResource(name, url, init(), mapping()
                for sprite in allSprites.results! {
                    let newPokemon = Pokemon()
                    let spriteURL = NSURL(string: sprite.url!)
                    let spriteData = NSData(contentsOfURL: spriteURL!)
                    do{
                        let json = try NSJSONSerialization.JSONObjectWithData(spriteData!, options: .AllowFragments)
                        if  let spriteURL = json["sprites"]!!["front_default"] as? String,
                        let name = json["pokemon"]!!["name"] as? String,
                            let id = json["id"] as? Int {
                            
                                newPokemon.number = id
                                print("number: " + String(id))

                                newPokemon.name = name
                                print("json Name: " + name)
                                if let spriteURL = NSURL(string: spriteURL), let data = NSData(contentsOfURL: spriteURL) {
                                    newPokemon.sprite = UIImage(data: data)
                                }
                            print("number: " + String(newPokemon.number!))
                            print("name: " + newPokemon.name!)
//                            print("sprite: " + newPokemon.sprite)
                            print( " ")
                        }
                        } catch {
                            print("error fetching data from PokemonAPI")
                        }
                    self.allPokemon.append(newPokemon)
                    print("new Pokemon Added")
                }

            print(self.allPokemon)
            
            self.collectionView?.reloadData()
            print("view did reload")
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

