//
//  Pokemon.swift
//  PokeCheck
//
//  Created by Ike Mattice on 8/31/16.
//  Copyright © 2016 Ike Mattice. All rights reserved.
//

import Foundation


class Pokemon {
    let dexNumber: Int?
    let name: String?
    var isCaught: Bool
    
    init(dexNumber: Int, name: String) {
        self.dexNumber = dexNumber
        self.name = name
        self.isCaught = false
    }
}
