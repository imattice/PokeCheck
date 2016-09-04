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
//import SwiftyGif

class ChecklistViewController: UICollectionViewController {
    var allPokemon: [Pokemon] = []
    
    let moc = DataController().managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        fectchAllPokemon()
        if allPokemon.isEmpty {
//            getAllPokemonSprites()
            initializeData()
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
        collectionView?.reloadData()
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
//        return 100
    }
    override func collectionView(collectionView: UICollectionView,
                                 cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokemonCell", forIndexPath: indexPath) as! PokemonCell
        let cellPokemon = allPokemon[indexPath.row]
        cell.pokemon = cellPokemon
        
        print(cell.pokemon)
        cell.configureCell(fromPokemon: cellPokemon)
        
        return cell
    }
    override func collectionView(collectionView: UICollectionView,
                                 didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! PokemonCell
            print(cell.pokemon)
            print(cell.pokemon?.isCaught)
        if cell.pokemon?.isCaught == false {
            CaughtIndicator.addPokeBall(toCell: cell, animated: true)
            cell.pokemon?.isCaught = true
            print("uncaught!")
            cell.cellImageView.stopAnimatingGif()
            cell.blur(thisImageView: cell.cellImageView)
        } else {
            CaughtIndicator.removePokeBall(fromCell: cell, animated: true)
            cell.pokemon?.isCaught = false
            cell.cellImageView.startAnimatingGif()
            cell.unblur(thisImageView: cell.cellImageView)
            print("caught!")
        }
//        cell.desaturate(UIImageView: cell.cellImageView)
//        if let cellPokemon = cell.pokemon {
//            if (cellPokemon.isCaught == false || cellPokemon.isCaught == nil) {
//                cellPokemon.isCaught = true
//                cell.blur(thisImageView: cell.cellImageView)
//                cell.toggleCheck()
////                cell.addCheck(toImageView: cell.cellImageView)
//                print(cellPokemon.isCaught)
//            } else {
//                cellPokemon.isCaught = false
//                cell.unblur(thisImageView: cell.cellImageView)
//                cell.toggleCheck()
//                print(cellPokemon.isCaught)
//            }
//
//            print(cellPokemon)
//        }
                
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
    func initializeData(){
        for (index, pokemonName) in pokemonArray.enumerate() {
            let dexNumber = index + 1 
            savePokemon(dexNumber, name: pokemonName)
        }
        fetchAllPokemon()
        collectionView?.reloadData()
    }

    func savePokemon(dexNumber: Int, name: String) {
        let entity = NSEntityDescription.insertNewObjectForEntityForName("Pokemon", inManagedObjectContext: moc) as! Pokemon
        
        entity.setValue(dexNumber, forKey: "dexNumber")
        entity.setValue(name, forKey: "name")
        print("\(name) has been saved.")
    }
    
    func fetchAllPokemon() -> (){
        let pokemonFetch = NSFetchRequest(entityName: "Pokemon")
        let fetchSort = NSSortDescriptor(key: "dexNumber", ascending: true)
        pokemonFetch.sortDescriptors = [fetchSort]

        do {
            let requestedPokemon = try moc.executeFetchRequest(pokemonFetch) as! [Pokemon]
            allPokemon = requestedPokemon
            print("allPokemon array has been filled with data")
            print(allPokemon)
        } catch {
            print("bad things happened \(error)")
        }
    }
    
///    PMNPagedObject.results -> [PKMNamedAPIResource.url] -> JSON Object -> "sprites" : {"front_default" : endurl}
    func getAllPokemonFromAPI() {
        print("will request forms")
        fetchPokemons().then {
//          allSprites => PKMPagedObject(count, next, previous, results, init(), mapping())
            allPokemon -> Void in
            print("recieved sprites.  Will begin looping")
//                allSprites => [PKMNamedAPIResource]?
//                sprite => PKMNamedAPIResource(name, url, init(), mapping()
                for pokemon in allPokemon.results! {
//                    print("no sprite data")
                    let spriteData = NSData(contentsOfURL: NSURL(string: pokemon.url!)!)
//                    print("sprite data: \(spriteData)")
                    do{
//                        transform json data into a Swift object
                        let json = try NSJSONSerialization.JSONObjectWithData(spriteData!, options: .AllowFragments)
                        print("did the json")
//                        go through the json object and set local variables to the important information
                        if  let name = json["pokemon"]!!["name"] as? String,
                            let id = json["id"] as? Int {
                                print("will set properties")
//                                set the properties to a new Pokemon entity in Core Data
                                self.savePokemon(id, name: name)
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

