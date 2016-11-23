//
//  Filter.swift
//  PokeCheck
//
//  Created by Ike Mattice on 9/5/16.
//  Copyright © 2016 Ike Mattice. All rights reserved.
//

import Foundation
import UIKit

class FilterView: UIView {
    class func create(inView view: UIView, animated: Bool) -> FilterView {
        let filterView = FilterView(frame: view.bounds)
            filterView.isOpaque = false
        
        return filterView
    }
}
