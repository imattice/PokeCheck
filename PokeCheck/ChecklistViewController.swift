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
    override func viewDidLoad() {
        super.viewDidLoad()
        PokemonKit.fetchPokemonForm("2").then {
            berryInfo in
                print(berryInfo.sprites?.frontDefault)
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
}

extension ChecklistViewController {
    override func collectionView(collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokemonCell", forIndexPath: indexPath) as! PokemonCell
        return cell
    }
}

