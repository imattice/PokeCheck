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
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "first section"
        case 1: return "second section"
        default: return "default section"
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0: 
            return UINib(nibName: TableCellNames.CaughtSearchCell.rawValue, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CaughtSearchCell
            
        case 1:
            return UINib(nibName: TableCellNames.NameSearchCell.rawValue, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! NameSearchCell
        case 2:
            return UINib(nibName: TableCellNames.GenerationSearchCell.rawValue, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! GenerationSearchCell
        case 3:
            return UINib(nibName: TableCellNames.LocationSearchCell.rawValue, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! LocationSearchCell
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
