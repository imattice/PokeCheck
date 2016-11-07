//
//  ViewController.swift
//  PokeCheck
//
//  Created by Ike Mattice on 8/16/16.
//  Copyright © 2016 Ike Mattice. All rights reserved.
//

import UIKit
import CoreData

class ChecklistViewController: UICollectionViewController, UISearchBarDelegate {
    let moc = DataController().managedObjectContext
    
    //var allPokemon: [Pokemon] = []
    var checklist = Checklist()
}

//INITIALIZING
extension ChecklistViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //fectchAllPokemon()
        //if allPokemon.isEmpty {
        if checklist.list.isEmpty {
            initializeData()
        } else {
            collectionView?.reloadData()
        }
        
        //Register nib
        collectionView?.register(UINib(nibName: "PokemonCell", bundle: nil), forCellWithReuseIdentifier: "PokemonCell")

    //STYLES:
        collectionView?.backgroundColor = UIColor.white
        }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("recieved Memory warning!!!")
    }
    
    @IBAction func filter() {

    }
}

//COLLECTION VIEW CONTOLLER FUNCTIONS
extension ChecklistViewController:UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        if checklist.list.isEmpty {
            return 1
        }
        
//        if searchBarIsActive {
//            return dataSourceForSearchResult.count
//        }
        
        return (checklist.list.count)
    }
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCell", for: indexPath) as! PokemonCell
        let cellPokemon = checklist.list[indexPath.row]
        
//        if searchBarIsActive {
////            celPokemon = dataSourceForSearchResult[indexPath.row]
//        }
        
        cell.pokemon = cellPokemon
        
//        print(cell.pokemon)
        cell.configureCell(fromPokemon: cellPokemon)
        
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PokemonCell

//      toggle capture image effects
        if cell.pokemon?.isCaught == false {
            cell.caughtPokemon(withAnimation: true)
        } else {
            cell.releasePokemon(withAnimation: true)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70.0, height: 70.0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, 
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
}


//CORE DATA
extension ChecklistViewController {
    func initializeData(){
        for (index, pokemonName) in pokemonNames.enumerated() {
            let dexNumber = index + 1
            print(dexNumber)
            print(pokemonName)
            savePokemon(dexNumber, name: pokemonName)
        }
        fetchAllPokemon()
        collectionView?.reloadData()
    }

    func savePokemon(_ dexNumber: Int, name: String) {
        let entity = NSEntityDescription.insertNewObject(forEntityName: "Pokemon", into: moc) as! Pokemon
        
        entity.setValue(dexNumber, forKey: "dexNumber")
        entity.setValue(name, forKey: "name")
        print("\(name) has been saved.")
    }
    
    func fetchAllPokemon() -> (){
        let pokemonFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Pokemon")
        let fetchSort = NSSortDescriptor(key: "dexNumber", ascending: true)
        pokemonFetch.sortDescriptors = [fetchSort]

        do {
            let requestedPokemon = try moc.fetch(pokemonFetch) as! [Pokemon]
            checklist.list = requestedPokemon
            print("allPokemon array has been filled with data")
            print()
        } catch {
            print("bad things happened \(error)")
        }
    }
    
///    PMNPagedObject.results -> [PKMNamedAPIResource.url] -> JSON Object -> "sprites" : {"front_default" : endurl}
//    func getAllPokemonFromAPI() {
//        print("will request forms")
//        fetchPokemons().then {
////          allSprites => PKMPagedObject(count, next, previous, results, init(), mapping())
//            allPokemon -> Void in
//            print("recieved sprites.  Will begin looping")
////                allSprites => [PKMNamedAPIResource]?
////                sprite => PKMNamedAPIResource(name, url, init(), mapping()
//                for pokemon in allPokemon.results! {
////                    print("no sprite data")
//                    let spriteData = NSData(contentsOfURL: NSURL(string: pokemon.url!)!)
////                    print("sprite data: \(spriteData)")
//                    do{
////                        transform json data into a Swift object
//                        let json = try NSJSONSerialization.JSONObjectWithData(spriteData!, options: .AllowFragments)
//                        print("did the json")
////                        go through the json object and set local variables to the important information
//                        if  let name = json["pokemon"]!!["name"] as? String,
//                            let id = json["id"] as? Int {
//                                print("will set properties")
////                                set the properties to a new Pokemon entity in Core Data
//                                self.savePokemon(id, name: name)
//                            print("did set properties")
//                            }
//                        } catch {
//                            print("error fetching data from PokemonAPI")
//                        }
//                }
//
////            once all data has been pulled, reload the collection view
//                self.fetchAllPokemon()
//        }
//    }
}

