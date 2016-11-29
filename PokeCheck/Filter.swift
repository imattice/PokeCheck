//
//  Filter.swift
//  PokeCheck
//
//  Created by Ike Mattice on 11/28/16.
//  Copyright © 2016 Ike Mattice. All rights reserved.
//

import UIKit


class Filter: UIView, UINavigationBarDelegate {
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!

    class func createFilterView() -> UIView {
        return UINib(nibName: "Filter", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
    @IBAction func close() {
        //self.dismiss(animated: true, completion: nil)
    }
}
