//
//  ViewController.swift
//  PokeCheck
//
//  Created by Ike Mattice on 8/16/16.
//  Copyright © 2016 Ike Mattice. All rights reserved.
//

import UIKit
import PokemonKit
import CoreData

class ChecklistViewController: UICollectionViewController {
    var allPokemon: [Pokemon] = []
    
    let moc = DataController().managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        fectchAllPokemon()
        if allPokemon.isEmpty {
            getAllPokemonSprites()
        } else {
            collectionView?.reloadData()
        }
        //Register nib
        collectionView?.registerNib(UINib(nibName: "PokemonCell", bundle: nil), forCellWithReuseIdentifier: "PokemonCell")
        
        //STYLES: 
        collectionView?.backgroundColor = UIColor.whiteColor()
        }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("recieved Memory warning!!!")
    }
    
    @IBAction func filter() {
        fetchAllPokemon()
    }
}

//COLLECTION VIEW CONTOLLER FUNCTIONS
extension ChecklistViewController:UICollectionViewDelegateFlowLayout {
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
                let cellPokemon = allPokemon[indexPath.row]
            //ties the cell to the pokemon at the index of the allPokemon array
                    cell.pokemon = cellPokemon
                    print("pokemon name: " + cell.pokemon!.name!)
                if let cellPokemon = cell.pokemon, let pokemonID = cellPokemon.dexNumber {
                    cell.cellLabel.text = String(pokemonID)
                }
                if let cellPokemon = cell.pokemon, let pokemonImage = cellPokemon.sprite {
                    cell.cellImage.image = UIImage(data: pokemonImage)
                    print(cellPokemon)
                } else {
                    cell.cellImage.image = UIImage(named: "0")
                }
            }
        return cell
    }
    override func collectionView(collectionView: UICollectionView,
                                 didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! PokemonCell
        if let cellPokemon = cell.pokemon {
            if (cellPokemon.isCaught == nil) {
                cellPokemon.isCaught = true
            } else {
                cellPokemon.isCaught = false
            }

            print(cellPokemon)
        }
        
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, 
                        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 75.0, height: 75.0)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, 
                        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
//        <#code#>
//    }
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
//        <#code#>
//    }
}


//Core Data and POKEMON Stuff
extension ChecklistViewController {
    func savePokemon(dexNumber: Int, name: String, image: NSData) {
        let entity = NSEntityDescription.insertNewObjectForEntityForName("Pokemon", inManagedObjectContext: moc) as! Pokemon
        
        entity.setValue(dexNumber, forKey: "dexNumber")
        entity.setValue(name, forKey: "name")
        entity.setValue(image, forKey: "sprite")
    }
    
    func fetchAllPokemon(){
        let pokemonFetch = NSFetchRequest(entityName: "Pokemon")
        let fetchSort = NSSortDescriptor(key: "dexNumber", ascending: true)
        pokemonFetch.sortDescriptors = [fetchSort]

        do {
            let requestedPokemon = try moc.executeFetchRequest(pokemonFetch) as! [Pokemon]
            allPokemon = requestedPokemon
            collectionView?.reloadData()
        } catch {
            print("bad things happened \(error)")
        }
    }
    
///    PMNPagedObject.results -> [PKMNamedAPIResource.url] -> JSON Object -> "sprites" : {"front_default" : endurl}
    func getAllPokemonSprites() {
        print("will request forms")
        fetchPokemonForms().then {
//            allSprites => PKMPagedObject(count, next, previous, results, init(), mapping())
            
            allSprites -> Void in
            
            print("recieved sprites.  Will begin looping")
//                allSprites => [PKMNamedAPIResource]?
//                sprite => PKMNamedAPIResource(name, url, init(), mapping()
                for sprite in allSprites.results! {
//                    print("no sprite data")
                    let spriteData = NSData(contentsOfURL: NSURL(string: sprite.url!)!)
//                    print("sprite data: \(spriteData)")
                    do{
//                        transform json data into a Swift object
                        let json = try NSJSONSerialization.JSONObjectWithData(spriteData!, options: .AllowFragments)
                        print("did the json")
//                        go through the json object and set local variables to the important information
                        if  let spriteURL = json["sprites"]!!["front_default"] as? String, let data = NSData(contentsOfURL: NSURL(string: spriteURL)!),
                            let name = json["pokemon"]!!["name"] as? String,
                            let id = json["id"] as? Int {
                                print("will set properties")
//                                set the properties to a new Pokemon entity in Core Data
                                self.savePokemon(id, name: name, image: data)
                            print("did set properties")
                            }
                        } catch {
                            print("error fetching data from PokemonAPI")
                        }
                }

//            once all data has been pulled, reload the collection view
                self.fetchAllPokemon()
        }
    }
}

