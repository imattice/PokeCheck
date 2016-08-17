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
        PokemonKit.fetchBerry("1").then { berryInfo in
                print(berryInfo.name)
            }
        }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("recieved Memory warning!!!")
    }
}

