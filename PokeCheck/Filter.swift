//
//  Filter.swift
//  PokeCheck
//
//  Created by Ike Mattice on 11/28/16.
//  Copyright © 2016 Ike Mattice. All rights reserved.
//

import UIKit


class Filter: UIView {
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    class func createFilterView() -> UIView {
        
//        tableView?.register(UINib(nibName: "PokemonCell", bundle: nil), forCellWithReuseIdentifier: "PokemonCell")
        
        return UINib(nibName: "Filter", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    @IBAction func close() {
        print("closed")
        //self.dismiss(animated: true, completion: nil)
    }
}

extension Filter: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection was called")
        return 2
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        print("titleForHeaderInSection was called")

        switch section {
        case 0: return "first section"
        case 1: return "second section"
        default: return "default section"
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellForRowAt indexPath was called")
                
        switch indexPath.section {
        case 0: 
            return UINib(nibName: "GenerationSearchCell", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! GenerationSearchCell
        default:
            return UITableViewCell()
        }
    }
}

extension Filter: UINavigationBarDelegate {
    func position(for: UIBarPositioning) -> UIBarPosition {
        print("navBar position was called")

        return .top
    }
}
