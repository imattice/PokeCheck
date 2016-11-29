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
    var checklist = Checklist()
    var animated: Bool = true
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
        presentFilterView(animated: true)
    }
}

//COLLECTION VIEW CONTOLLER FUNCTIONS
extension ChecklistViewController:UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        if checklist.list.isEmpty {
            return 1
        }
        return (checklist.list[section].count)
//        return 4
    }
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCell", for: indexPath) as! PokemonCell
        let cellPokemon = checklist.list[indexPath.section][indexPath.row]
    
        
        cell.pokemon = cellPokemon
        
//        print(cell.pokemon)
        cell.configureCell(fromPokemon: cellPokemon, animated: true)
        
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
            headerView.backgroundColor = .white

            let alpha = CGFloat(0.4)
            
            switch indexPath.section {
            case 0:
                
                let label = "Kanto Pokemon"

                let redColor = UIColor(red: 221/255, green: 87/255, blue: 65/255, alpha: alpha).cgColor
                let blueColor = UIColor(red: 56/255, green: 130/255, blue: 176/255, alpha: alpha).cgColor
                let yellowColor = UIColor(red: 241/255, green: 209/255, blue: 86/255, alpha: alpha).cgColor
                
                
                headerView.add(withLabel: label, andColors: [redColor, blueColor, yellowColor])

            case 1:
                let label = "Johto Pokemon"
                
                let goldColor = UIColor(red: 156/255, green: 134/255, blue: 92/255, alpha: alpha).cgColor
                let silverColor = UIColor(red: 92/255, green: 98/255, blue: 106/255, alpha: alpha).cgColor
                let crystalColor = UIColor(red: 106/255, green: 114/255, blue: 171/255, alpha: alpha).cgColor
                
                headerView.add(withLabel: label, andColors: [goldColor, silverColor, crystalColor])
                
            case 2:
                let label = "Hoenn Pokemon"
                
                let rubyColor = UIColor(red: 214/255, green: 91/255, blue: 60/255, alpha: alpha).cgColor
                let sapphireColor = UIColor(red: 50/255, green: 120/255, blue: 185/255, alpha: alpha).cgColor
                let emeraldColor = UIColor(red: 74/255, green: 163/255, blue: 88/255, alpha: alpha).cgColor
            
                headerView.add(withLabel: label, andColors: [rubyColor, sapphireColor, emeraldColor])
                
            case 3:
                let label = "Sinnoh Pokemon"
                
                let diamondColor = UIColor(red: 174/255, green: 217/255, blue: 225/255, alpha: alpha).cgColor
                let pearlColor = UIColor(red: 228/255, green: 221/255, blue: 224/255, alpha: alpha).cgColor
                let platinumColor = UIColor(red: 180/255, green: 180/255, blue: 182/255, alpha: alpha).cgColor
                
                headerView.add(withLabel: label, andColors: [diamondColor, pearlColor, platinumColor])
                
            case 4:
                let label = "Unova Pokemon"
                
                let blackColor = UIColor(red: 4/255, green: 4/255, blue: 4/255, alpha: alpha).cgColor
                let whiteColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: alpha).cgColor
                
                headerView.add(withLabel: label, andColors: [blackColor, whiteColor])

            case 5:
                let label = "Kalos Pokemon"
                
                let xColor = UIColor(red: 100/255, green: 117/255, blue: 177/255, alpha: alpha).cgColor
                let yColor = UIColor(red: 213/255, green: 69/255, blue: 48/255, alpha: alpha).cgColor
                
                headerView.add(withLabel: label, andColors: [xColor, yColor])

            case 6:
                let label = "Aloha Pokemon"
                
                let sunColor = UIColor(red: 229/255, green: 162/255, blue: 64/255, alpha: alpha).cgColor
                let moonColor = UIColor(red: 75/255, green: 54/255, blue: 135/255, alpha: alpha).cgColor
                
                headerView.add(withLabel: label, andColors: [sunColor, moonColor])

                
            default:
                assert(false, "Something went wrong when creating header view")
            }
            
            return headerView
        default:
            assert(false, "Unexpected element kind")
        }
    }
}

//FILTER MANAGEMENT
extension ChecklistViewController {
    func presentFilterView(animated: Bool) {
        
        let filterMenu = ModalViewController.createFilterMenu()
        
        present(filterMenu, animated: true, completion: nil)
    }

    func createFilterMenu() {
        
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

