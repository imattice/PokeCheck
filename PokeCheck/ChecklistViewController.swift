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
    var allPokemon: [Pokemon] = []
    let moc = DataController().managedObjectContext

    let searchController = UISearchController(searchResultsController: nil)
    var dataSourceForSearchresult: [Pokemon] = []
    var searchBarIsActive = false
    var searchBarBoundsY: CGFloat? = nil
    var searchBar: UISearchBar? = nil
    var refreshControl: UIRefreshControl? = nil
    
    func refreshControlAction(){
        cancelSearching()
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.collectionView?.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count > 0 {
            searchBarIsActive = true
            collectionView?.reloadData()
        } else {
            searchBarIsActive = false
            collectionView?.reloadData()
        }
    }
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBarIsActive = true
        view.endEditing(true)
    }
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchBarIsActive = false
        searchBar.setShowsCancelButton(false, animated: false)
    }
    func cancelSearching() {
        searchBarIsActive = false
        searchBar?.resignFirstResponder()
        searchBar?.text = ""
    }
    func prepareUI() {
        addSearchBar()
        addRefreshControl()
    }
    func addSearchBar() {
        if searchBar == nil {
            searchBarBoundsY = (navigationController?.navigationBar.frame.size.height)! + UIApplication.sharedApplication().statusBarFrame.size.height + 50
            
            searchBar = UISearchBar(frame: CGRectMake(0, searchBarBoundsY!, UIScreen.mainScreen().bounds.size.width, 44))
            searchBar?.searchBarStyle = UISearchBarStyle.Minimal
            searchBar?.tintColor = UIColor.redColor()
            searchBar?.barTintColor = UIColor.redColor()
            searchBar?.delegate = self
            searchBar?.placeholder = "search here"
            
            print("search bar should have been added")
            addObservers()
        }
    }
    func addRefreshControl() {
        if refreshControl == nil {
            refreshControl = UIRefreshControl()
            refreshControl?.tintColor = UIColor.whiteColor()
            refreshControl?.addTarget(self, action: #selector(ChecklistViewController.refreshControlAction), forControlEvents: UIControlEvents.ValueChanged)
        }
        if ((refreshControl?.isDescendantOfView(collectionView!)) != nil) {
            collectionView?.addSubview(refreshControl!)
        }
    }
    func startRefreshControl() {
        if refreshControl!.refreshing {
            refreshControl?.beginRefreshing()
        }
    }
    func addObservers() {
        let context = UnsafeMutablePointer<Int8>(bitPattern: 1)
        collectionView!.addObserver(self, forKeyPath: "contentOffset", options: [.New, .Old], context: context)
    }
    func removeObservers() {
        collectionView!.removeObserver(self, forKeyPath: "contentOffset")
    }
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "contentOffset" {
            if let collectionV:UICollectionView = object as? UICollectionView {
                searchBar!.frame = CGRectMake(
                    searchBar!.frame.origin.x,
                    searchBarBoundsY! + ((-1 * collectionV.contentOffset.y) - searchBarBoundsY!),
                    searchBar!.frame.size.width,
                    searchBar!.frame.size.height
                )
            }
        }
    }
    deinit {
        removeObservers()
    }
}

//INITIALIZING
extension ChecklistViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
//      fectchAllPokemon()
        if allPokemon.isEmpty {
            initializeData()
        } else {
            collectionView?.reloadData()
        }
        
//      Register nib
        collectionView?.registerNib(UINib(nibName: "PokemonCell", bundle: nil), forCellWithReuseIdentifier: "PokemonCell")

//      STYLES:
        collectionView?.backgroundColor = UIColor.whiteColor()
        }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        prepareUI()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("recieved Memory warning!!!")
    }
    
    @IBAction func filter() {
//        startSearch(searchController)
        prepareUI()
    }
}

//COLLECTION VIEW CONTOLLER FUNCTIONS
extension ChecklistViewController:UICollectionViewDelegateFlowLayout {
    override func collectionView(collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        if allPokemon.isEmpty {
            return 1
        }
        
//        if searchBarIsActive {
//            return dataSourceForSearchResult.count
//        }
        
        return (allPokemon.count)
    }
    override func collectionView(collectionView: UICollectionView,
                                 cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokemonCell", forIndexPath: indexPath) as! PokemonCell
        var cellPokemon = allPokemon[indexPath.row]
        
        if searchBarIsActive {
//            celPokemon = dataSourceForSearchResult[indexPath.row]
        }
        
        cell.pokemon = cellPokemon
        
//        print(cell.pokemon)
        cell.configureCell(fromPokemon: cellPokemon)
        
        return cell
    }
    override func collectionView(collectionView: UICollectionView,
                                 didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! PokemonCell

//      toggle capture image effects
        if cell.pokemon?.isCaught == false {
            cell.caughtPokemon(cell)
        } else {
            cell.releasePokemon(cell)
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
}


//CORE DATA
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

