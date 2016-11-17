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
            //initializeData()
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
//        print("pressed")
//        checklist.list = checklist.filterBy(.BlackWhite)
//        collectionView?.reloadData()
    }
}

//COLLECTION VIEW CONTOLLER FUNCTIONS
extension ChecklistViewController:UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        if checklist.list.isEmpty {
            return 1
        }
        print("section: \(section), checklist.list: \(checklist.list.count)")
        return (checklist.list[section].count)
    }
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCell", for: indexPath) as! PokemonCell
        let cellPokemon = checklist.list[indexPath.section][indexPath.row]
    
        
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
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        
        switch kind {
        case UICollectionElementKindSectionHeader:

            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ChecklistHeaderView", for: indexPath) as! ChecklistHeaderView    
            let gradientLayer = CAGradientLayer()
            headerView.backgroundColor = .white
            let alpha = CGFloat(0.7)
            
            switch indexPath.section {
            case 0:
                headerView.label.text = "Generation 1: Red, Blue, Yellow"
                
                gradientLayer.frame = headerView.bounds
                let redColor = UIColor(red: 221.0, green: 87.0, blue: 65.0, alpha: alpha)
                let blueColor = UIColor(red: 56.0, green: 130.0, blue: 176.0, alpha: alpha)
                let yelloColor = UIColor(red: 241.0, green: 209.0, blue: 86.0, alpha: alpha)
                
                gradientLayer.colors = [redColor, blueColor, yelloColor]
                gradientLayer.locations = [0.0, 0.5, 1.0]
                
                headerView.layer.addSublayer(gradientLayer)
            case 1:
                headerView.label.text = "Generation 2: Gold, Silver, Crystal"
            
            case 2:
                headerView.label.text = "Generation 3: Ruby, Sapphire, Emerald"
            case 3:
                headerView.label.text = "Generation 4: Diamond, Pearl, Platinum"
            case 4:
                headerView.label.text = "Generation 5: Black, White"
            case 5:
                headerView.label.text = "Generation 6: X, Y"
            case 6:
                headerView.label.text = "Generation 7: Sun, Moon"
                
            default:
                assert(false, "Something went wrong when creating header view")
            }
            
            return headerView
        default:
            assert(false, "Unexpected element kind")
        }
    }
}


//CORE DATA
extension ChecklistViewController {
//    func initializeData(){
//        for (index, pokemonName) in pokemonNames.enumerated() {
//            let dexNumber = index + 1
//            //print(dexNumber)
//            //print(pokemonName)
//            savePokemon(dexNumber, name: pokemonName)
//        }
//        fetchAllPokemon()
//        collectionView?.reloadData()
//    }
//
//    func savePokemon(_ dexNumber: Int, name: String) {
//        let entity = NSEntityDescription.insertNewObject(forEntityName: "Pokemon", into: moc) as! Pokemon
//        
//        entity.setValue(dexNumber, forKey: "dexNumber")
//        entity.setValue(name, forKey: "name")
//        //print("\(name) has been saved.")
//    }
//    
//    func fetchAllPokemon() -> (){
//        let pokemonFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Pokemon")
//        let fetchSort = NSSortDescriptor(key: "dexNumber", ascending: true)
//        pokemonFetch.sortDescriptors = [fetchSort]
//
//        do {
//            let requestedPokemon = try moc.fetch(pokemonFetch) as! [Pokemon]
//            checklist.list = requestedPokemon
//            //print("allPokemon array has been filled with data")
//            //print()
//        } catch {
//            //print("bad things happened \(error)")
//        }
//    }
    
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

