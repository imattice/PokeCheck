//
//  ChecklistHeaderView.swift
//  PokeCheck
//
//  Created by Ike Mattice on 11/16/16.
//  Copyright © 2016 Ike Mattice. All rights reserved.
//

import UIKit

class ChecklistHeaderView: UICollectionReusableView {
    
    func add(withLabel title: String, andColors gradientColors: [CGColor]) {
        
        let gradientLayer = CAGradientLayer()
            gradientLayer.frame = self.bounds
            gradientLayer.colors = gradientColors
            //gradientLayer.locations = [0.0, 0.5, 1.0]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        
        self.layer.addSublayer(gradientLayer)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
            label.textAlignment = .center
            label.text = title
            label.sizeToFit()

        self.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
//        let xConstraint = NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
//        let yConstraint = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
//        
//        NSLayoutConstraint.activate([xConstraint, yConstraint])
    }
}
