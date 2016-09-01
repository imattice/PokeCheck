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
    
    var pokemon: Pokemon?
 
    func blur(imageView: UIImageView) {
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
        imageView.addSubview(blurredEffectView)

    }
    func unblur(imageView: UIImageView) {
        for subview in imageView.subviews {
            if subview is UIVisualEffectView {
                subview.removeFromSuperview()
            }
        }
    }
}