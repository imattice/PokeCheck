//
//  PokemonCell.swift
//  PokeCheck
//
//  Created by Ike Mattice on 8/17/16.
//  Copyright © 2016 Ike Mattice. All rights reserved.
//

import UIKit


class PokemonCell: UICollectionViewCell {
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellCheckLabel: UILabel!
    
    var pokemon: Pokemon?
 
    func toggleCheck() {
        if let cellPokemon = pokemon {
            if (cellPokemon.isCaught == true) {
                cellCheckLabel.text = "\u{2713}"
            } else {
                cellCheckLabel.text = ""
            }
        }
    }
    
    func blur(thisImageView imageView: UIImageView) {
        let blurEffect = UIBlurEffect(style: .ExtraLight)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = imageView.bounds
        blurredEffectView.alpha = 0.5
//        blurredEffectView.frame.insetInPlace(dx: 25.0, dy: 5.0)
//        let vibrancyEffect = UIVibrancyEffect(forBlurEffect: blurEffect)
//        let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
//        vibrancyEffectView.frame = imageView.bounds
//        
//        imageView.addSubview(vibrancyEffectView)
        addCheck(toImageView: blurredEffectView)

        imageView.addSubview(blurredEffectView)
        

    }
    func unblur(thisImageView imageView: UIImageView) {
        for subview in imageView.subviews {
            if subview is UIVisualEffectView {
                subview.removeFromSuperview()
            }
        }
    }
    
    func addCheck(toImageView imageView: UIVisualEffectView) {
//        let view = UIView()
//            view.frame = imageView.bounds
        
        let textField = UITextField()
            textField.text = "OOO"//"\u{2713}"
            textField.minimumFontSize = 16
        
            textField.textAlignment = .Center
            textField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
            textField.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        
//        view.addSubview(textField)
        imageView.addSubview(textField)
        print("added check")
    }
}