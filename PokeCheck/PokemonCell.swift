//
//  PokemonCell.swift
//  PokeCheck
//
//  Created by Ike Mattice on 8/17/16.
//  Copyright © 2016 Ike Mattice. All rights reserved.
//

import UIKit
import SwiftyGif


class PokemonCell: UICollectionViewCell {
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellCheckLabel: UILabel!
    
    let gifManager = SwiftyGifManager(memoryLimit: 50)

    var pokemon: Pokemon?
 
    func configureCell(fromPokemon pokemon: Pokemon) {
//      add the dexNumber to the bottom of the cell
        let dexNumber = pokemon.dexNumber
        cellLabel.text = String(dexNumber!)
        
        var gifName = "?"

//      append the appropriate amount of 0's to the image name
        switch Int(dexNumber!) {
        case 1...9:
            gifName = "00\(dexNumber!)"
        case 10...99:
            gifName = "0\(dexNumber!)"
        case 100...999:
            gifName = "\(dexNumber!)"
        default:
            cellImageView.image = UIImage(named: "1")
        }
        
//      set the label and the image of the cell to the appropriate number and gif
        let gif = UIImage(gifName: gifName)
        print("gif: \(gif) \n gifname: |(gifName)")
        cellImageView.setGifImage(gif, manager: gifManager)
        
//      get the height and width of the cell and the gif
        let gifHeight = cellImageView.currentImage.size.height
        let gifWidth = cellImageView.currentImage.size.width
        let cellHeight = frame.size.height
        let cellWidth = frame.size.width
        
//      if the gif is larger that the cell, scale the gif down.  Otherwise, display it on the bottom of the cell
        if gifHeight > cellHeight || gifWidth > cellWidth {
            cellImageView.contentMode = .ScaleAspectFit
        } else {
            cellImageView.contentMode = .Bottom
        }
        
//      if pokemon has already been caught, apply blur
        if pokemon.isCaught == true {
            cellImageView.stopAnimatingGif()
            blur(thisImageView: cellImageView)
        }

    }
    
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
//        addCheck(toImageView: blurredEffectView)

        imageView.addSubview(blurredEffectView)
        

    }
    func unblur(thisImageView imageView: UIImageView) {
        for subview in imageView.subviews {
            if subview is UIVisualEffectView {
                subview.removeFromSuperview()
            }
        }
    }
    func desaturate(UIImageView imageView: UIImageView) {
        //        let scaleFactor = UIScreen.mainScreen().scale
        //        let extent = CGRect(x: 0, y: 0, width: imageView.frame., height: <#T##CGFloat#>)
        let filter = CIFilter(name: "CIColorMonochrome")
        let context = CIContext(options: nil)
        let ciImage = CIImage(image: imageView.currentImage)
        
        filter!.setValue(ciImage, forKey: kCIInputImageKey)
        
        imageView.image = UIImage(CGImage: context.createCGImage(filter!.outputImage!, fromRect: imageView.frame))
        
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellImageView.image = nil
        cellLabel.text = nil
        unblur(thisImageView: cellImageView)
    }
}