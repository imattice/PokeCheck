//
//  Pokemon.swift
//  PokeCheck
//
//  Created by Ike Mattice on 10/16/16.
//  Copyright © 2016 Ike Mattice. All rights reserved.
//

import UIKit

class Pokemon {
    let id: Int
    let name: String
    let image: UIImage?
    let isCaught: Bool
    
    
    init(id: Int, name: String, image: UIImage = nil, isCaught: Bool = false) {
        self.id = id
    }
}
