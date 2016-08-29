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
                                newPokemon.name = name
                                if let spriteURL = NSURL(string: spriteURL), let data = NSData(contentsOfURL: spriteURL) {
                                    newPokemon.sprite = UIImage(data: data)
                                }
                            
//                            print("Json: \(json)")
//                            print(spriteURL)
//                            print(name)
//                            print(id)
                            
//                            print("number: " + newPokemon.number as? String)
                            print("name: " + newPokemon.name!)
//                            print("sprite: " + newPokemon.sprite)
                            print( " ")
                        }
                        } catch {
                            print("nope")
                        }
                }
//                    
//                    let pokemonMap = Map(mappingType: .FromJSON, JSONDictionary: self.pokemonDict)
//                    parseJSON(fromAPIResults: spriteURL)
//                    print(spriteURL)
//                    self.allPokemonSprites.append(sprite.url!)
            print(self.allPokemon)

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

