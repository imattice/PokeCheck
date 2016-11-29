//
//  FrostedModal.swift
//  PokeCheck
//
//  Created by Ike Mattice on 11/28/16.
//  Copyright © 2016 Ike Mattice. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {
//    class func frostedModalPane(navController: UINavigationController) -> UIView {
//        let frostedPane = UIView(frame: navController.view.bounds)
//        frostedPane.backgroundColor = UIColor(colorLiteralRed: 130/255, green: 130/255, blue: 130/255, alpha: 0.7)
//        frostedPane.tag = 100
//        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(self.close(sender:)))
////        tap.delegate = self 
//        
//        frostedPane.addGestureRecognizer(tap)
//        
//        //navController.view.isUserInteractionEnabled = false 
//        frostedPane.isUserInteractionEnabled = true 
//        
//        return frostedPane
//    }
    
    func close(sender: UITapGestureRecognizer) {
        print("Modal will close")
    }

    override func viewDidLoad() {
        view.backgroundColor = UIColor(colorLiteralRed: 130/255, green: 130/255, blue: 130/255, alpha: 0.7)
        view.isOpaque = false 
    }
    
    class func createFilterMenu() -> ModalViewController {
        let filterMenu = Filter.createFilterView()        
        
        let modalView = ModalViewController()
            modalView.modalTransitionStyle = .crossDissolve
            modalView.modalPresentationStyle = .overCurrentContext
        
        modalView.view.addSubview(filterMenu)
        
        return modalView
    }
}
